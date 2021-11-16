#!/bin/bash -l
#SBATCH --job-name=CUDA_demo     # job name
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --partition=GPU          # partition to use
#SBATCH --gres=gpu:1             # number of gpus per node

# Config 
julia_path="$HOME" # where to place julia
original_path="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )" # folder of script

# Run script
$julia_path/julia-1.6.3/bin/julia $original_path/CUDA_demo.jl