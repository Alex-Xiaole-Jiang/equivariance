#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --time=3:00:00
#SBATCH --mem=32GB
#SBATCH --gres=gpu:1
#SBATCH --job-name=model_eval
#SBATCH --mail-type=END
#SBATCH --mail-user=xj2173@nyu.edu
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err

module purge

singularity exec --nv \
  --overlay /vast/xj2173/singularity_envir/diffeo-env.ext3:ro \
  --overlay /vast/work/public/ml-datasets/imagenet/imagenet-val.sqf:ro \
  --overlay /vast/work/public/ml-datasets/imagenet/imagenet-test.sqf:ro \
  --overlay /vast/work/public/ml-datasets/imagenet/imagenet-train.sqf:ro \
  /scratch/work/public/singularity/cuda12.1.1-cudnn8.9.0-devel-ubuntu22.04.2.sif \
  /bin/bash -c "source /ext3/env.sh; \
  python /vast/xj2173/equivariance/experiments/001_AccuracyDiffeos/simulation.py --model_name swin_s --num_images 1000"
