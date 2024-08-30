# A place to keep track of ddRAD bioinformatics steps

# Logging onto CHPC with Terminal on a mac
1. Open Terminal
2. ssh u6036559@notchpeak.chpc.utah.edu        #replace with your username
3. salloc --time=72:00:00 --ntasks 1 --mem=100G --account=saarman-np --partition=saarman-shared-np

# Prepare input files  

## Upload files to CHPC group1 storage
SFTP file transfer protocol with Cyberduck worked easily.  
Select SFTP at the top.  
Server: notchpeak  
User: u6036559  
Port: 21  
Drag and drop from local disk.  
/uufs/chpc.utah.edu/common/home/saarman-group1/bee_ddRAD_raw  

## To unzip a .tar.gz file:
```
tar –xvzf bee_ddRAD_plate1.tar.gz
mv ./data/Saarman/ddRAD/ddRAD.fastq.gz ./bee_ddRAD_plate1.fastq.gz
```

## Change permissions
```
chmod -R g+w /uufs/chpc.utah.edu/common/home/saarman-group1/bee_ddRAD*
```

# Submit your job to slurm 
https://www.chpc.utah.edu/documentation/software/slurm.php#usingslurm

```
cd /uufs/chpc.utah.edu/common/home/saarman-group1/bee_ddRAD_scripts
sbatch 1a_process_radtags_nps.slurm
```
