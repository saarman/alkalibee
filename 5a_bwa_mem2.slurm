#!/bin/sh
#SBATCH --time=336:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=10          #half of my $max set in ForkManager
#SBATCH --account=saarman-np
#SBATCH --partition=saarman-shared-np   
#SBATCH --job-name=bwa-mem2
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=norah.saarman@usu.edu

module load samtools
##Version: 1.16 (using htslib 1.16)

cd /uufs/chpc.utah.edu/common/home/saarman-group1/bee_ddRAD_bwa
perl /uufs/chpc.utah.edu/common/home/saarman-group1/bee_ddRAD_scripts/alkalibee/5a_bwa_mem2.pl /uufs/chpc.utah.edu/common/home/saarman-group1/bee_ddRAD_processed/*.fq.gz 
