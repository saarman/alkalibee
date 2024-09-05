#!/bin/bash

# job standard output will go to the file slurm-%j.out (where %j is the job ID)

#SBATCH --partition=saarman-shared-np   
#SBATCH --account=saarman-np
#SBATCH --time=24:00:00   # walltime limit (HH:MM:SS)
#SBATCH --mem=24576 # memory given in MB
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=16   # 20 processor core(s) per node X 2 threads per core
#SBATCH --job-name="bwa-ref"
#SBATCH --mail-user=norah.saarman@usu.edu   # email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

# Load modules
module load bwa/0.7.17

# Replace these variables with the actual paths and filenames
input_folder="/project/piru_hylaues/KochProjects/alkalibeepopgen/stacks_pipeline/process_radtags_plate2"
output_folder="/project/piru_hylaues/KochProjects/alkalibeepopgen/stacks_pipeline/bwa/aligned_plate2"
reference_genome="/project/piru_hylaues/KochProjects/alkalibeepopgen/stacks_pipeline/bwa/reference_genome/GCA_003710045.2_USU_Nmel_1.3_genomic.fa"

bwa index -a bwtsw GCA_003710045.2_USU_Nmel_1.3_genomic.fa
