#!/bin/bash

# michaelm Thu Nov 24 16:03:46 CET 2022

# Job name:
#SBATCH --job-name=r_frame
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
alignment_dir=`readlink -f ${1}`
table=`readlink -f ${2}`

# Count the numbers of stop codons per frame.
rm -f ${table}
touch ${table}
for fasta in ${alignment_dir}/*.fa
do
    fasta_base=`basename ${fasta}`
    echo -ne "${fasta_base}\t" >> ${table}
    python3 count_stop_codons_per_frame.py ${fasta} >> ${table}
done
