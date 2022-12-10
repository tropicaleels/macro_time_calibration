#!/bin/bash

# michaelm Fri Nov 25 11:44:29 CET 2022

# Job name:
#SBATCH --job-name=gc_cont
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

# Get the command-line arguments.
input_dir=`readlink -f ${1}`
output_dir=`readlink -f ${2}`
gc_threshold=${3}

# Filter all alignments by their gc-content variation.
ruby filter_alignments_by_GC_content_variation.rb ${input_dir} ${output_dir} ${gc_threshold}
