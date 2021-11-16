using Logging

# Logging setup
io = open("multithreading_log.txt", "w+")
mylogger = Logging.SimpleLogger(io)

# Actual code
with_logger(mylogger) do
    @info "Multithreading demo:\n → Available threads: $(Threads.nthreads())"
    Threads.@threads for i in 1:20
        @info "\n\titeration $(i) on thread $(Threads.threadid())\n" 
    end
end

# Cleanup
flush(io)
close(io)