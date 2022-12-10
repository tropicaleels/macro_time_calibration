#!/bin/bash

# michaelm Fri Nov 25 01:07:06 CET 2022

# Job name:
#SBATCH --job-name=bmge
#
# Wall clock limit:
#SBATCH --time=10:00:00
#
# Processor and memory usage:
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G

# Set up job environment.
set -o errexit
set -o nounset
module purge &> /dev/null
module load  Ruby/3.0.1-GCCcore-11.2.0
module load Java/17.0.2

# Get the command-line arguments.
bmge_dir=${1}
input_dir=${2}
output_dir=${3}
gap_rate_cut_off=${4}
entropy_like_score_cut_off=${5}

# Filter sites for missing data and entropy with BMGE.
ruby filter_sites_with_BMGE.rb ${bmge_dir} ${input_dir} ${output_dir} ${gap_rate_cut_off} ${entropy_like_score_cut_off}
