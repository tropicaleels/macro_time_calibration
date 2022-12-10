#!/bin/bash

# m_matschiner Tue Nov 29 00:08:26 CET 2022

# Job name:
#SBATCH --job-name=split_by_codon_position
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
module load Ruby/3.0.1-GCCcore-11.2.0

# Get the command-line arguments.
input_dir=${1}
output_dir=${2}

# Split alignments by codon positions.
for nex in ${input_dir}/*.nex
do
    nex_id=`basename ${nex%.nex}`
    ruby split_by_cp.rb -i ${nex}
    mv ${input_dir}/${nex_id}_1.nex ${output_dir}
    mv ${input_dir}/${nex_id}_2.nex ${output_dir}
    rm -f ${input_dir}/${nex_id}_3.nex
done
