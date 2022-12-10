#!/bin/bash

# m_matschiner Sun Nov 27 12:08:59 CET 2022

# Job name:
#SBATCH --job-name=make_mcc_trees_per_alignment
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

# Load modules.
module load R/4.1.0-foss-2021a
module load Beast/2.6.7-GCC-10.3.0-CUDA-11.3.1

# Get the command-line arguments.
input_dir=${1}

# Generate a maximum-clade-credibility consensus tree for each alignment.
for trees in ${input_dir}/*/*.trees
do
    trees_id=`basename ${trees%.trees}`
    cd ${input_dir}/${trees_id}
    trees_base=${trees_id}.trees
    tre=${trees_id}.tre
    if [ ! -f ${tre} ]
    then
        treeannotator -burnin 10 -heights mean ${trees_base} ${tre}
    fi
    cd - &> /dev/null
done

# Convert each consensus tree to newick format.
for tre in ${input_dir}/*/*.tre
do
    nwk=${tre%.tre}.nwk
    Rscript convert_nexus_tree_to_newick.r ${tre} ${nwk}
done
