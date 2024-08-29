# A place to keep track of ddRAD bioinformatics steps

## Logging onto CHPC with Terminal on a mac
1. Open Terminal
2. ssh u6036559@notchpeak.chpc.utah.edu        #replace with your username
3. salloc --time=72:00:00 --ntasks 1 --mem=100G --account=saarman-np --partition=saarman-shared-np

# Prepare input files  
```
cd /uufs/chpc.utah.edu/common/home/saarman-group1/bee_ddRAD_raw
tar –xvzf bee_ddRAD_plate1.tar.gz
tar -xvfj bee_ddRAD_plate2.tar

```

## change permissions
```
chmod -R g+w /uufs/chpc.utah.edu/common/home/saarman-group1/bee_ddRAD_raw
```
