#!/bin/bash
#SBATCH --job-name=pluto
#SBATCH --nodes=1
#SBATCH --ntasks=1               # total number of tasks (workers) across all nodes
#SBATCH --cpus-per-task=27        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --partition=80CORE          # use GPU partition or CORE80 or ...
#SBATCH --mem=16g 

# Config 
julia_path="$HOME" # where to place julia
script_path="$HOME/machjulia"
port=3300 # port for notebook server

# forward port from actual notebook server machine to login server
# This does not work for the DGX cluster :-( => why?
# gives following error: Host key verification failed.
/usr/bin/ssh -N -f -R $port:localhost:$port mach.intra.rma.ac.be
# then on the intermediate machine:
# ssh -L 3300:localhost:3300 -N user@mach.intra.rma.ac.be
# and the nested one:
# ssh -L 3300:localhost:3300 -N user@intermediate machine 

# control to start notebook
command="$julia_path/julia-1.6.3/bin/julia -e 'using Pluto; Pluto.run(port=$port, launch_browser=false, require_secret_for_access=false, threads=$SLURM_CPUS_PER_TASK)'"
echo $command
# start the notebook on local machine
eval " $command"

: '
inspiration/source: http://www.utkuevci.com/notes/port-forwarding/

'