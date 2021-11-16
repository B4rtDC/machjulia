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
- 1 PROCESS
- 17 THREADS
'

echo "Starting job!!! ${SLURM_JOB_ID}"

# Config 
julia_path="$HOME" # where to place julia
script_path="$HOME/machjulia"
original_path="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )" # folder of script

echo "julia path: $julia_path"
echo "original path: $original_path"


julia -e 'println("\n"); [println((k,ENV[k],)) for k in keys(ENV) if occursin("SLURM",k)]; println("\n");'

# Run script with amount of threads
$julia_path/julia-1.6.3/bin/julia --threads ${SLURM_CPUS_PER_TASK} $script_path/mt.jl