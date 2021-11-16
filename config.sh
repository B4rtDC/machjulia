# config file to get you started

# Dwnload latest julia version
download_path="$HOME/downloads"
julia_path="$HOME"
mkdir -p $download_path
cd $download_path
echo "Downloading in <$download_path>"

# get latest julia build and extract
wget https://julialang-s3.julialang.org/bin/linux/x64/1.6/julia-1.6.3-linux-x86_64.tar.gz
tar zxvf julia-1.6.3-linux-x86_64.tar.gz
mv "$download_path/julia-1.6.3" "$julia_path"

# run julia and install required packages
"$julia_path/julia-1.6.3/bin/julia" config.jl

