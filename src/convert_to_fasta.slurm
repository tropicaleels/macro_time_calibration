#!/bin/bash

# michaelm Fri Nov 25 11:44:29 CET 2022

# Job name:
#SBATCH --job-name=convertf
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
module load Python/3.10.4-GCCcore-11.3.0

# Get the command-line arguments.
input_dir=`readlink -f ${1}`
output_dir=`readlink -f ${2}`

# Convert all alignments to fasta format
for align in ${input_dir}/*.fa
do
    align_base=`basename ${align}`
    fasta=${output_dir}/${align_base}
    python3 convert.py ${align} ${fasta} -f fasta
done
