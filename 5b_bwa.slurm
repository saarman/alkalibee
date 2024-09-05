#!/bin/bash

# job standard output will go to the file slurm-%j.out (where %j is the job ID)

#SBATCH --partition=saarman-shared-np   
#SBATCH --account=saarman-np
#SBATCH --time=24:00:00   # walltime limit (HH:MM:SS)
#SBATCH --mem=24576 # memory given in MB
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=16   # 20 processor core(s) per node X 2 threads per core
#SBATCH --job-name="bwa"
#SBATCH --mail-user=norah.saarman@usu.edu   # email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

# Load modules
module load bwa/2020_03_19
module load samtools/1.16

# Replace these variables with the actual paths and filenames
input_folder="/uufs/chpc.utah.edu/common/home/saarman-group1/bee_ddRAD_processed/"
output_folder="/uufs/chpc.utah.edu/common/home/saarman-group1/bee_ddRAD_bwa/"
reference_genome="/uufs/chpc.utah.edu/common/home/saarman-group1/bee_ddRAD_bwa/ref/GCF_003710045.2_USU_Nmel_1.3_genomic.fna"

# Permissions
chmod -R g+w /uufs/chpc.utah.edu/common/home/saarman-group1/bee_ddRAD*

for fastq_file in "$input_folder"/*.fq.gz; do
    if [ -f "$fastq_file" ]; then
        # Extract the sample name from the filename
        sample_name=$(basename "$fastq_file" .fq.gz)

        # Align reads using BWA
        bwa mem -M -t 4 "$reference_genome" "$fastq_file" |
        samtools view -b |
        samtools sort --threads 4 > "$output_folder/$sample_name.bam"
        echo "Alignment completed for $sample_name"
    fi
done

# Permissions
chmod -R g+w /uufs/chpc.utah.edu/common/home/saarman-group1/bee_ddRAD*

# Resource
# https://catchenlab.life.illinois.edu/stacks/manual/#refmapbyhand
