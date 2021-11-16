# Julia config file to get started
using Pkg

@info "Julia is installing packages"
for pkg in ["Plots", 
            "Distributed", 
            "SlurmClusterManager",
            "ClusterManagers",
            "CUDA",
            "BenchmarkTools",
            "Pluto"]
    Pkg.add(pkg)
end

@info "Installation finished"