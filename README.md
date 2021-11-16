# Julia on Slurm cluster

1. get an account on the cluster
2. get Julia and the required packages on your account
    
    ```
    bash path/to/config.sh
    ```
   
   The required dependencies will be installed based on `config.jl`. You can also work with virtual environments if you wish.
3. Run required Julia scripts. The following demos are included:
    - multithreading on a single node
        
        `mt.sh`

    - multithreading on multiple nodes (multiprocessing)

        `mpmt.sh`

    - using the DGX station for GPU computing

        `CUDA.sh`