#!/bin/bash

# michaelm Fri Nov 25 14:27:29 CET 2022

# Job name:
#SBATCH --job-name=concat
#
# Wall clock limit:
#SBATCH --time=10:00:00
#
# Processor and memory usage:
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=10G

# Set up job environment.
set -o errexit
set -o nounset
module purge &> /dev/null
module load  Ruby/3.0.1-GCCcore-11.2.0

# Get the command-line arguments.
input_nexs="${1}"
concatenated_nex=${2}

# Concatenate the alignments.
ruby concatenate.rb -i ${input_nexs} -o ${concatenated_nex} -f nexus
