#!/bin/sh
#SBATCH --time=240:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --account=gompert-np
#SBATCH --partition=gompert-np
#SBATCH --job-name=bwa-mem2
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=zach.gompert@usu.edu

module load samtools
##Version: 1.16 (using htslib 1.16)


cd /scratch/general/nfs1/u6000989/lyc_pool4
perl /scratch/general/nfs1/u6000989/lyc_pool4/BwaMemFork.pl /uufs/chpc.utah.edu/common/home/gompert-group4/data/Lyc_pool_d2/data/F24A480000157_BUTlgxuR/upload/soapnuke/clean/*/*1.fq.gz 
