using Logging

# Logging setup
io = open("multithreading_log.txt", "w+")
mylogger = Logging.SimpleLogger(io)

# Actual code
with_logger(mylogger) do
    @info "Available threads: $(Threads.nthreads())"
    Threads.@threads for i in 1:20
        @info "iteration $(i) on thread $(Threads.threadid())" 
    end
end

# Cleanup
flush(io)
close(io)