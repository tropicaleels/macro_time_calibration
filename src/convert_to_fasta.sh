# m_matschiner Fri Nov 25 11:40:05 CET 2022

# Set the account.
acct=nn9883k

# Make the results directory.
mkdir -p ../res/alignments/02

# Set the log file.
log=../log/misc/convert_to_fasta.txt

# Set the input and output directories.
input_dir=../res/alignments/01
output_dir=../res/alignments/02

# Convert all files to fasta format.
sbatch -A ${acct} -o ${log} convert_to_fasta.slurm ${input_dir} ${output_dir}
