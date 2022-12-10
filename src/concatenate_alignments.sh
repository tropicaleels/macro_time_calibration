# m_matschiner Fri Nov 25 14:16:34 CET 2022

# Get the concatenate script.
if [ ! -f concatenate.rb ]
then
    wget https://raw.githubusercontent.com/mmatschiner/notothenioid_phylogenomics/master/src/concatenate.rb
fi

# Set the input alignments.
input_nexs_1="../res/alignments/08/*_1.nex"
input_nexs_2="../res/alignments/08/*_2.nex"

# Set the concatenated alignments.
concatenated_nex_1=../res/alignments/concatenated_1.nex
concatenated_nex_2=../res/alignments/concatenated_2.nex

# Set the account.
acct=nn9883k

# Set the first log file.
log_1=../log/misc/concatenate_1.txt
rm -f ${log_1}

# Concatenate all alignments of the first codon position.
sbatch -A ${acct} -o ${log_1} concatenate_alignments.slurm "${input_nexs_1}" ${concatenated_nex_1}

# Set the second log file.
log_2=../log/misc/concatenate_2.txt
rm -f ${log_2}

# Concatenate all alignments of the second codon position.
sbatch -A ${acct} -o ${log_2} concatenate_alignments.slurm "${input_nexs_2}" ${concatenated_nex_2}
