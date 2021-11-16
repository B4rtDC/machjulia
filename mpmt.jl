using Distributed
using ClusterManagers
# read settings
num_workers = parse(Int, ENV["SLURM_NTASKS"])
num_threads = parse(Int, ENV["SLURM_CPUS_PER_TASK"])


# create workers
#addprocs_slurm(num_workers, env=["JULIA_NUM_THREADS"=>num_threads])
addprocs(SlurmManager(num_workers), cpus_per_task="$(num_threads)")

@everywhere begin
    function myfun(i)
        println("iteration $(i) on worker $(myid()) on host $(gethostname())")
        #sleep(1)
        return i
    end

    function print_id_2(x)
        pid = Distributed.myid()
        nth = Threads.nthreads()
        Threads.@threads for i in 1:nth
          tid = Threads.threadid()
          println("Hello from thread $tid of $nth on worker $pid. $(x[tid]) is from a vector")
        end
    end  
end

println("Number of cores: ", nprocs())
println("Number of workers: ", nworkers())

#=
for i in workers()
    # get description of everyone
    id, pid, host, tr = fetch(@spawnat i (myid(), getpid(), gethostname(), Threads.nthreads()))
    println(id, " " , pid, " ", host, " ", tr)
    myfun(i)
    #@info "worker id: $(id), process id: $(pid), host: $(host)"
end
=#
#
#@sync @distributed for i = 1:200
#    myfun(i)
#end

# do work
pmap(print_id_2, collect(1:200))

# remove workers after work
rmprocs(workers())