# michaelm Fri Nov 25 01:10:44 CET 2022

# Make the result directory.
mkdir -p ../res/alignments/03

# Make the binary directory.
mkdir -p ../bin

# Download bmge.
if [ ! -f ../bin/BMGE.jar ]
then
    wget ftp://ftp.pasteur.fr/pub/gensoft/projects/BMGE/BMGE-1.12.tar.gz
    tar -xzf BMGE-1.12.tar.gz
    rm -rf BMGE-1.12.tar.gz
    mv -f BMGE-1.12/BMGE.jar ../bin
    rm -rf BMGE-1.12
fi

# Set the account.
acct=nn9883k

# Set the log file.
log=../log/misc/filter_sites_with_BMGE.txt
rm -f ${log}

# Set variables.
input_dir=../res/alignments/02
output_dir=../res/alignments/03
gap_rate_cut_off=0.2
entropy_like_score_cut_off=0.5

# Filter sites with bmge.
sbatch -A ${acct} -o ${log} filter_sites_with_BMGE.slurm ../bin/BMGE.jar ${input_dir} ${output_dir} ${gap_rate_cut_off} ${entropy_like_score_cut_off}
