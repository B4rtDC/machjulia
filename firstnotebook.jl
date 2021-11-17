### A Pluto.jl notebook ###
# v0.17.1

using Markdown
using InteractiveUtils

# ╔═╡ f5b27226-aab1-4eff-9634-600faf38d767
md"""
# Pluto on the mach cluster
"""

# ╔═╡ 7e5a09b8-cbac-4b11-8ac0-269baf3e3e11
md"""
We asked to be on the $(ENV["SLURM_JOB_PARTITION"]) with $(ENV["SLURM_NPROCS"]) worker(s) using $(ENV["SLURM_CPUS_PER_TASK"]) thread(s) per worker.

We are on as system that has $(length(Sys.cpu_info())) $(Sys.cpu_info()[1].model) CPU(s). The number of available threads is $(Threads.nthreads()).

Total system memory can be found from within Julia: 
 - free:  $(round(Int, Float64(Sys.free_memory())/1024^3)) Gb
 - total: $(round(Int, Float64(Sys.total_memory())/1024^3)) Gb

In practice however, our memory is limited by the amount we attributed by SLURM. The node memory is set at $(ENV["SLURM_MEM_PER_NODE"]) Mb. When trying to allocate a 50000x50000 matrix, we get an out of memory error. This is to be expected, as this would requires 29Gb (using Float64).

"""

# ╔═╡ 76002539-82b3-41a6-85a8-4d95420164a1
begin
        try
                A = rand(50000,50000)
        catch err
                "$(err)"
        end
end

# ╔═╡ b19857df-793f-4302-a798-d790297c163d
md"""
Other SLURM environment variables are shown below:
"""

# ╔═╡ 1c1faf59-1168-42f9-9d66-0c3295a71cdc
[(key, ENV[key]) for key in keys(ENV) if occursin("SLURM",key)]

# ╔═╡ Cell order:
# ╟─f5b27226-aab1-4eff-9634-600faf38d767
# ╟─7e5a09b8-cbac-4b11-8ac0-269baf3e3e11
# ╠═76002539-82b3-41a6-85a8-4d95420164a1
# ╟─b19857df-793f-4302-a798-d790297c163d
# ╠═1c1faf59-1168-42f9-9d66-0c3295a71cdc