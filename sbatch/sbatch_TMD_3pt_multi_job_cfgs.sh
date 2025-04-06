#!/bin/bash
#SBATCH --nodes=3
#SBATCH --ntasks-per-node=64
#SBATCH --cpus-per-task=4
#SBATCH --qos=regular
#SBATCH --time=00:17:00
#SBATCH --constraint=cpu
#SBATCH --account=m230
#SBATCH --mail-type=ALL
#SBATCH --mail-user=hari1729@nmsu.edu
#SBATCH --array=0-69
#SBATCH --output=TMD_%A_%a.out
#SBATCH --error=TMD_%A_%a.err

export OMP_NUM_THREADS=1

# Change to the directory containing your qlua script
cd /pscratch/sd/h/hari_8/TMD/propagator

cfg_no=$((1776 + SLURM_ARRAY_TASK_ID * 4))

job_name="save_prop_cfg${cfg_no}"

srun -n 192 --export=CFG=$cfg_no --job-name=${job_name} /pscratch/sd/e/engel/QLUA/installation-202212-rc3-gcc/qlua/bin/qlua cfg.qlua ThreePT_TMD_cfg_b210_cfgb_check_MDB.qlua
