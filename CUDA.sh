# run as on cluster as follows=
# sbatch -p GPU path/to/CUDA.sh

# Config 
julia_path="$HOME" # where to place julia
original_path="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )" # folder of script

# Run script
$julia_path/julia-1.6.3/bin/julia $original_path/CUDA_demo.jl