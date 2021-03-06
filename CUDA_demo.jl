#=
The DGX station contains 4 Nvidia Tesla V100 cards with 32Gb of RAM on each of them. 
Because there are multiple cards, getting it to work appears to be a bit tricky.

When trying to do work on only one GPU, the example below appears to work

=#

using Distributed, CUDA
println(device())
println([CUDA.capability(dev) for dev in CUDA.devices()])

#=
# single proces, using all four GPUs
@sync begin
    @async begin
        device!(0)
        # do work on GPU 0 here
        println("running on device $(device())")

        #a = CuArray{Float32}(undef, 100)
        #rand!(a)
        #println(typeof(a)," ", a)
    end
    @async begin
        device!(1)
        # do work on GPU 1 here
        println("running on device $(device())")
        #b = CuArray{Float32}(undef, 10)
        #rand!(b)
        #println(typeof(b)," ", b)
    end
end
=#

# spawn one worker per device
using Distributed, CUDA
addprocs(length(devices()))
@everywhere using CUDA

# assign devices
asyncmap((zip(workers(), devices()))) do (p, d)
    remotecall_wait(p) do
        @info "Worker $p uses $d"
        device!(d)
    end
end
