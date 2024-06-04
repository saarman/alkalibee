#########################################
#STEP 3: Filter out SNPs with missingness above thresholds, but keep all individuals for now.
#########################################
#PLINK to convert VCF to PLINK:
NAME=stacks2_all_noRPs
cd /home/nps25/project/results/nRef_2019_ddRAD/VCF_files/
plink --vcf $NAME.recode.vcf --double-id --allow-extra-chr --make-bed --out $NAME
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

