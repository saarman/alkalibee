#!/bin/bash

# job standard output will go to the file slurm-%j.out (where %j is the job ID)

#SBATCH --time=24:00:00   # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=40   # 20 processor core(s) per node X 2 threads per core
#SBATCH --partition=short    # standard node(s)
#SBATCH --job-name="stacks"
#SBATCH --mail-user=jonathan.koch@usda.gov   # email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

# Load Module
module load plink

# Input and output
out_path="/project/piru_hylaues/KochProjects/alkalibeepopgen/stacks_pipeline/populations_output_2"
popmap="/project/piru_hylaues/KochProjects/alkalibeepopgen/popmap2/nomia_popmap_plate1_plate2"
in_path="/project/piru_hylaues/KochProjects/alkalibeepopgen/stacks_pipeline/refmap_output13"

# Code: Filter out SNPs with missingness above thresholds, but keep all individuals for now.

#PLINK to convert VCF to PLINK:
NAME=
plink --vcf $NAME.vcf --double-id --allow-extra-chr --make-bed --out $NAME
plink --bfile $NAME --double-id --allow-extra-chr --recode tab --out $NAME

#PLINK to filter by missing data:
cp /dev/null $NAME.missing.log
plink --file $NAME --geno .7 --double-id --allow-extra-chr --recode --out ${NAME}_geno70           >> $NAME.missing.log
plink --file ${NAME}_geno70 --mind .7 --double-id --allow-extra-chr --recode --out ${NAME}_mind70    >> $NAME.missing.log
plink --file ${NAME}_mind70 --geno .65 --double-id --allow-extra-chr --recode --out ${NAME}_geno65    >> $NAME.missing.log
plink --file ${NAME}_geno65 --mind .65 --double-id --allow-extra-chr --recode --out ${NAME}_mind65    >> $NAME.missing.log
plink --file ${NAME}_mind65 --geno .6 --double-id --allow-extra-chr --recode --out ${NAME}_geno60    >> $NAME.missing.log
plink --file ${NAME}_geno60 --mind .6 --double-id --allow-extra-chr --recode --out ${NAME}_mind60    >> $NAME.missing.log
plink --file ${NAME}_mind60 --geno .55 --double-id --allow-extra-chr --recode --out ${NAME}_geno55    >> $NAME.missing.log
plink --file ${NAME}_geno55 --mind .55 --double-id --allow-extra-chr --recode --out ${NAME}_mind55    >> $NAME.missing.log
plink --file ${NAME}_mind55 --geno .5 --double-id --allow-extra-chr --recode --out ${NAME}_geno50    >> $NAME.missing.log
plink --file ${NAME}_geno50 --mind .5 --double-id --allow-extra-chr --recode --out ${NAME}_mind50    >> $NAME.missing.log
cat $NAME.missing.log | grep "QC."

#Extract sites from missing filters:

cat ${NAME}_mind50.map | awk '{print $1 "\t" $4}' > ${NAME}_mind50.pos
NAME=stacks2_all_noRPs
vcftools --vcf /home/nps25/project/results/nRef_2019_ddRAD/VCF_files/${NAME}.recode.vcf \
--positions /home/nps25/project/results/nRef_2019_ddRAD/VCF_files/${NAME}_mind50.pos \
--recode --out /home/nps25/project/results/nRef_2019_ddRAD/VCF_files/${NAME}_missing

