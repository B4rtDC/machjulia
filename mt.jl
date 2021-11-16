# Logging setup
io = open("multithreading_log.txt", "w+")
mylogger = Logging.SimpleLogger(io)

# Actual code
with_logger(mylogger) do
    @info "Available threads: $(Threads.nthreads())"
end

# Cleanup
flush(io)
close(io)