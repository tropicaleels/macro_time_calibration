# michaelm Sun Nov 27 12:48:40 CET 2022

# Set the account.
acct=nn9883k

# Make the output directory.
mkdir -p ../res/tables

# Set the input directory.
input_dir=../res/alignments/06

# Set the results file.
table=../res/tables/alignment_stats.txt

# Get required scripts.
if [ -f get_number_of_variable_sites.rb ]
then
    wget wget https://raw.githubusercontent.com/mmatschiner/notothenioid_phylogenomics/master/src/get_number_of_variable_sites.rb
fi
if [ ! -f get_rate_variation_from_log.rb ]
then
    wget https://raw.githubusercontent.com/mmatschiner/notothenioid_phylogenomics/master/src/get_rate_variation_from_log.rb
fi
if [ ! -f get_mean_node_support.py ]
then
    wget https://raw.githubusercontent.com/mmatschiner/notothenioid_phylogenomics/master/src/get_mean_node_support.py
fi
if [ ! -f get_number_of_variable_sites.rb ]
then
    wget https://raw.githubusercontent.com/mmatschiner/notothenioid_phylogenomics/master/src/get_number_of_variable_sites.rb
fi
if [ ! -f get_number_of_pi_sites.rb ]
then
    wget https://raw.githubusercontent.com/mmatschiner/notothenioid_phylogenomics/master/src/get_number_of_pi_sites.rb
fi
if [ ! -f  get_min_ess.r ]
then
    wget https://raw.githubusercontent.com/mmatschiner/notothenioid_phylogenomics/master/src/get_min_ess.r
fi

# Set the log file.
log=../log/misc/get_alignment_stats.txt
rm -f ${log}

# Get all alignment stats.
sbatch -A ${acct} -o ${log} get_alignment_stats.slurm ${input_dir} ${table}
