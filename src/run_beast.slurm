#!/bin/bash

# m_matschiner Wed Apr 15 00:22:32 CEST 2020

# Job name:
#SBATCH --job-name=QQQQQQ
#
# Project:
#SBATCH --account=nn9883k
#
# Wall clock limit:
#
#SBATCH --time=168:00:00
#
# Processor and memory usage:
#SBATCH --ntasks-per-node=5
#SBATCH --mem-per-cpu=2G
#
# Outfile:
#SBATCH --output=QQQQQQ.out

## Set up job environment:
## Set up the job environment
set -o errexit  # Exit the script on any error
set -o nounset  # Treat any unset variables as an error
module --quiet purge  # Reset the modules to the system default
module load Beast/2.6.7-GCC-10.3.0-CUDA-11.3.1

## Run or resume beast analysis.
if [ ! -f QQQQQQ.log ]
then
    beast -threads 5 -seed ${RANDOM} -beagle QQQQQQ.xml
else
    beast -threads 5 -seed ${RANDOM} -beagle -resume QQQQQQ.xml
fi
