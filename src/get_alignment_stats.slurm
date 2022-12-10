#!/bin/bash

# m_matschiner Sun Nov 27 12:50:25 CET 2022

# Job name:
#SBATCH --job-name=get_alignment_stats
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
module load Python/3.9.6-GCCcore-11.2.0
module load Ruby/3.0.1-GCCcore-11.2.0
module load R/4.1.2-foss-2021b

# Unset to avoid warnings.
unset R_HOME

# Get the command-line argument.
input_dir=${1}
table=${2}

# Get the alignment length and the number of variable sites. 
echo -e "alignment_id\tlength\tn_missing\tn_var\tn_pi\tmean_bpp\tmut_rate\trate_var\tmin_ess" > ${table}
for nex in ${input_dir}/*/*.nex
do
    # Get the file id.
    file_id=`basename ${nex%.nex}`

    # Set the log and trees file names.
    log=${nex%.nex}.log
    trees=${nex%.nex}.trees
    tre=${nex%.nex}.tre

    # Get the alignment length.
    alignment_length=`head ${nex} | grep nchar | cut -d "=" -f 3 | tr -d ";"`

    # Get the number of completely missing taxa.
    n_missing=`tail -n +6 ${nex} | grep -v ";" | tr -s " " | cut -d " " -f 3 | grep -v "A" | grep -v "C" | grep -v "G" | grep -v "T" | wc -l  | tr -d " "`

    # Get the number of variable sites.
    n_variable_sites=`ruby get_number_of_variable_sites.rb ${nex}`

    # Get the number of parsimony-informative sites.
    n_pi_sites=`ruby get_number_of_pi_sites.rb ${nex}`

    # Get the mutation rate estimate.
    mutation_rate=`ruby get_rate_variation_from_log.rb ${log} | cut -f 1  | tr -d " "`
    mutation_rate_nice=`printf "%8.6f\n" "${mutation_rate}" | tr -d " "`

    # Get the coefficient of rate variation.
    coef_rate_variation=`ruby get_rate_variation_from_log.rb ${log} | cut -f 2  | tr -d " "`
    coef_rate_variation_nice=`printf "%8.4f\n" "${coef_rate_variation}" | tr -d " "`
    
    # Get the mean bpp support.
    mean_bpp=`python3 get_mean_node_support.py ${tre}`
    mean_bpp_nice=`printf "%8.4f\n" "${mean_bpp}" | tr -d " "`

    # Get the minum ess value from the log file.
    min_ess=`Rscript get_min_ess.r ${log}  | tr -d " "`

    # Feedback.
    echo -e "${file_id}\t${alignment_length}\t${n_missing}\t${n_variable_sites}\t${n_pi_sites}\t${mean_bpp_nice}\t${mutation_rate_nice}\t${coef_rate_variation_nice}\t${min_ess}" >> ${table}

done
