using Distributed
using ClusterManagers

# read settings
num_workers = parse(Int, ENV["SLURM_NTASKS"])
num_threads = parse(Int, ENV["SLURM_CPUS_PER_TASK"])

# "FAST OPERATION DEMO"
# ---------------------
println("FAST OPERATION DEMO\n")

# create workers
addprocs_slurm(num_workers)

# Some overview (controller)
println("Number of available processes: $(nprocs()) (= SLURM_NTASKS + 1)")
println("Number of available workers: $(nworkers()) (= SLURM_NTASKS)")
println("List of all process identifiers: $(procs()) (including pid1, i.e. the controller)")
println("List of all worker process identifiers: $(workers()) (identifiers)")
println("id of main controller: $(myid())")

# Fast operation => distributed for
@sync @distributed for i in 1:10
    println("""Total number of nodes in the job's resource allocation: $(ENV["SLURM_JOB_NODES"])""")
    println("""The relative node ID of the current node: $(ENV["SLURM_NODEID"])""")
    println("""Total number of nodes in the job's resource allocation: $(ENV["SLURM_JOB_NODES"])""")
    println("Worker $(myid()) is working on i=$(i)")
    Threads.@threads for j in 1:30
        println("\tworking on subtask $(j) on thread $(Threads.threadid())")
    end nodeid()
end

# kill workers
rmprocs(workers())




# "SLOW OPERATION DEMO"
# ---------------------
println("SLOW OPERATION DEMO\n")

# create workers
addprocs_slurm(num_workers)

# make data and packages known on each worker
@everywhere begin
    using SharedArrays # SharedArrays (needs to be on same host, see DistributedArrays.jl for arrays over multiple hosts
end




#=
procs()
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

    function wiener(x)
        return x^2
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
#pmap(print_id_2, collect(1:200))
pmap(wiener, collect(1:200))
# remove workers after work
println("done working!")
rmprocs(workers())
=#
