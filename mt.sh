#!/bin/bash -l
#
#SBATCH --partition 80CORE 
#SBATCH --nodes 1 # single node
#SBATCH --ntasks=1 # single process (worker)
#SBATCH --cpus-per-task=17 # 17 threads

: '
Using simple multithreading on a single blade

Note that the different settings for SLURM are added in the initial lines:
- 1 NODE
- 20 CORES

'

echo "Starting job!!! ${SLURM_JOB_ID}"

# Config 
julia_path="$HOME" # where to place julia
script_path="$HOME/machjulia"
original_path="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )" # folder of script

echo "julia path: $jula_path"
echo "original path: $original_path"

# print out environment variables related to SLURM_NTASKS
julia -e 'println("\n"); [println((k,ENV[k],)) for k in keys(ENV) if occursin("SLURM_NTASKS",k)]; println("\n");'
julia -e 'println("\n"); println("I have $(Threads.nthreads()) thread(s) available"); println("\n");'
julia --threads auto -e 'println("\n"); println("I have $(Threads.nthreads()) thread(s) available"); println("\n");'
julia -e `println("$(ENV)")`
# Run script
#$julia_path/julia-1.6.3/bin/julia --threads auto $script_path/mt.jl