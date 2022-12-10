# michaelm Sun Nov 27 11:52:57 CET 2022

# Set the account.
acct=nn9883k

# Set the log file.
log=../log/misc/make_mcc_trees_per_alignment.txt
rm -f ${log}

# Set the input directory.
input_dir=../res/alignments/06

# Make mcc trees.
sbatch -A ${acct} -o ${log} make_mcc_trees_per_alignment.slurm ${input_dir}
