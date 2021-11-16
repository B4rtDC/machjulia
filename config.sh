# Config file to get you started
original_path="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )" # folder of script
download_path="$HOME/downloads" # where to download
julia_path="$HOME" # where to place julia

# Download latest julia version
mkdir -p $download_path
cd $download_path
echo "Downloading in <$download_path>"
wget https://julialang-s3.julialang.org/bin/linux/x64/1.6/julia-1.6.3-linux-x86_64.tar.gz
tar zxvf julia-1.6.3-linux-x86_64.tar.gz
mv "$download_path/julia-1.6.3" "$julia_path"

# Run julia and install required packages
$julia_path/julia-1.6.3/bin/julia $original_path/config.jl

echo "Ready to work!"