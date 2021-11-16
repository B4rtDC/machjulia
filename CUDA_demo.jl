using CUDA, Logging

# Logging setup
io = open("CUDA_log.txt", "w+")
mylogger = Logging.SimpleLogger(io)

# Actual code
with_logger(mylogger) do
    @info CUDA.versioninfo()
    @info [CUDA.capability(dev) for dev in CUDA.devices()]
end

# Cleanup
flush(io)
close(io)