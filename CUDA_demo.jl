#=
The DGX station contains 4 Nvidia Tesla V100 cards with 32Gb of RAM on each of them. 
Because there are multiple cards, getting it to work appears to be a bit tricky.

When trying to do work on only one GPU, the example below appears to work

=#

using Distributed, CUDA

# add single worker process
addprocs(1)
@everywhere using CUDA
worker = workers()[1]
device = devices()[1]

# run task on single device
remotecall_wait(device) do
    device!(device)
    println("worker $(worker) uses device $(device)")
end

# assign devices
# asyncmap((zip(workers(), devices()))) do (p, d)
#     remotecall_wait(p) do
#         @info "Worker $p uses $d"
#         device!(d)
#     end
# end
# Logging setup
#io = open("CUDA_log.txt", "w+")
#mylogger = Logging.SimpleLogger(io)

#=
# Actual code
with_logger(mylogger) do
    @info CUDA.versioninfo()
    @info [CUDA.capability(dev) for dev in CUDA.devices()]
end
=#

#println(CUDA.versioninfo())
println([CUDA.capability(dev) for dev in CUDA.devices()])

# Cleanup
#flush(io)
#close(io)