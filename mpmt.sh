#!/bin/bash -l
#
#SBATCH --partition 80CORE 
#SBATCH --nodes 2 # two nodes
#SBATCH --ntasks 120 # 4 process in total(worker)
#SBATCH --cpus-per-task 5 # 5 threads per task => 40 in total

: '
detail idea
'

echo "Starting job!!! ${SLURM_JOB_ID}"

# Config 
julia_path="$HOME" # where to place julia
script_path="$HOME/machjulia"

# Run script
$julia_path/julia-1.6.3/bin/julia $script_path/mpmt.jl



