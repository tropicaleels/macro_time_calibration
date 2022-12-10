# m_matschiner Thu Nov 24 15:59:01 CET 2022

# Set the data directory.
alignment_dir=../data/alignments

# Make the log directory.
mkdir -p ../log/misc

# Set the account.
acct=nn9883k

# Set the log file.
log=../log/misc/count_stop_codons.out
rm -f ${log}

# Make the results directory.
mkdir -p ../res/tables

# Set the output table.
table=../res/tables/stop_codons.txt

# Count the number of stop codons per reading frame in each alignment.
sbatch -A ${acct} -o ${log} count_stop_codons.slurm ${alignment_dir} ${table}
