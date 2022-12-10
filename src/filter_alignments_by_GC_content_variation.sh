# m_matschiner Sat Nov 26 11:42:59 CET 2022

# Set the log file.
log=../log/misc/filter_alignments_by_GC_content_variation.txt
rm -f ${log}

# Set the account.
acct=nn9883k

# Set the input and output directories.
input_dir=../res/alignments/04
output_dir=../res/alignments/05

# Make the output directory.
mkdir -p ${output_dir}
rm -f ${output_dir}/*

# Set the gc-content variation threshold.
gc_threshold=0.05

# Filter alignments by gc-content variation.
sbatch -A ${acct} -o ${log} filter_alignments_by_GC_content_variation.slurm ${input_dir} ${output_dir} ${gc_threshold}
