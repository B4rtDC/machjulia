#!/bin/bash
#SBATCH --job-name=pluto-test
#SBATCH --nodes=1
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --partition=80core          # use GPU partition to use

# Config 
julia_path="$HOME" # where to place julia
script_path="$HOME/machjulia"

port=3300 # port for notebook server

# forward port from actual notebook server machine to login server
/usr/bin/ssh -N -f -R $port:localhost:$port mach.intra.rma.ac.be

# start the notebook
echo $julia_path/julia-1.6.3/bin/julia -e 'using Pluto; Pluto.run(port=$port, launch_browser=false)'

: '
source: http://www.utkuevci.com/notes/port-forwarding/

'