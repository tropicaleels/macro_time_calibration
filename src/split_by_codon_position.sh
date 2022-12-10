# m_matschiner Mon Nov 28 22:09:35 CET 2022

# Get the script to split alignments by codon positions.
if [ ! -f split_by_cp.rb ]
then
    wget https://raw.githubusercontent.com/mmatschiner/notothenioid_phylogenomics/4359b4ebe02ae378ae85ac099181976a1a9890cb/src/split_by_cp.rb
fi

# Set the input and output directories.
input_dir=../res/alignments/07
output_dir=../res/alignments/08

# Make the results directory.
mkdir -p ${output_dir}
rm -f ${output_dir}/*

# Set the account.
acct=nn9883k

# Set the log file.
log=../log/misc/split_by_codon_position.txt
rm -f ${log}

# Split all alignments into codon positions.
sbatch -A ${acct} -o ${log} split_by_codon_position.slurm ${input_dir} ${output_dir}
