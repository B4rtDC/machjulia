#!/bin/bash
#
#SBATCH --partition 80CORE 
#SBATCH --nodes 2 # two nodes
#SBATCH --ntasks 6 # 4 process in total(worker)
#SBATCH --cpus-per-task 10 # 10 threads per task => 40 in total
export JULIA_NUM_THREADS=$SLURM_CPUS_PER_TASK

: '
detail idea
'

echo "Starting job!!! ${SLURM_JOB_ID}"

# Config 
julia_path="$HOME" # where to place julia
script_path="$HOME/machjulia"

# Run script
$julia_path/julia-1.6.3/bin/julia $script_path/mpmt.jl



