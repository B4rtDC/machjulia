#!/bin/sh
#
#SBATCH -p 80CORE 
#SBATCH -N 1 
#SBATCH -n 20

: '
Using simple multithreading on a single blade

Note that the different settings for SLURM are added in the initial lines:
- 1 NODE
- 20 CORES

'

# Config 
julia_path="$HOME" # where to place julia
original_path="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )" # folder of script

echo "julia path: $jula_path"
echo "original path: $original_path"
# Run script
$julia_path/julia-1.6.3/bin/julia --threads auto $original_path/mt.jl