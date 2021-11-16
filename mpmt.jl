using Distributed
using Logging

# Logging setup
io = open("mpmt_log.txt", "w+")
mylogger = Logging.SimpleLogger(io)

# read settings
num_workers = parse(Int, ENV["SLURM_NTASKS"])
num_threads = parse(Int, ENV["SLURM_CPUS_PER_TASK"])


# create workers
addprocs(num_workers, :env=["JULIA_NUM_THREADS"=>num_threads])
with_logger(mylogger) do
    println("Number of cores: ", nprocs())
    println("Number of workers: ", nworkers())

    for i in workers()
        id, pid, host = fetch(@spawnat i (myid(), getpid(), gethostname()))
        println(id, " " , pid, " ", host)
    end
end


# Cleanup
flush(io)
close(io)