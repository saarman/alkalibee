#!/bin/bash

# job standard output will go to the file slurm-%j.out (where %j is the job ID)

#SBATCH --partition=saarman-shared-np   
#SBATCH --account=saarman-np
#SBATCH --time=24:00:00   # walltime limit (HH:MM:SS)
#SBATCH --mem=24576 # memory given in MB
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=16   # 20 processor core(s) per node X 2 threads per core
#SBATCH --job-name="fastqc"
#SBATCH --mail-user=norah.saarman@usu.edu   # email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

# Load Module
module load  multiqc/1.12

# Input and output files
in_path="/project/piru_hylaues/KochProjects/alkalibeepopgen/stacks_pipeline/fastqc_plate2/"
outdir="/project/piru_hylaues/KochProjects/alkalibeepopgen/stacks_pipeline/fastqc_plate2/multiqc"

multiqc $in_path --outdir $outdir
