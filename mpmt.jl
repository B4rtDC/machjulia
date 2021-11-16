using Distributed

# read settings
num_workers = parse(Int, ENV["SLURM_NTASKS"])
num_threads = parse(Int, ENV["SLURM_CPUS_PER_TASK"])


# create workers
addprocs(num_workers)#, :env=["JULIA_NUM_THREADS"=>num_threads])


println("Number of cores: ", nprocs())
println("Number of workers: ", nworkers())

for i in workers()
    # get description of everyone
    id, pid, host, tr = fetch(@spawnat i (myid(), getpid(), gethostname(), Threads.nthreads()))
    println(id, " " , pid, " ", host, " ", tr)
    #@info "worker id: $(id), process id: $(pid), host: $(host)"
end
