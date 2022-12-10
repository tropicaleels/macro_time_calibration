# m_matschiner Fri Nov 25 00:51:07 CET 2022

# Make the results directory.
mkdir -p ../res/alignments/01

# Copy all alignments without stop codons in the first frame.
while read line
do
    fasta=`echo ${line} | cut -d " " -f 1`
    n_stop_codons=`echo ${line} | cut -d " " -f 2`
    if [ ${n_stop_codons} == "0" ]
    then
        echo -n "Copying ${fasta}..."
        cp ../data/alignments/${fasta} ../res/alignments/01
        echo " done."
    fi
done < ../res/tables/stop_codons.txt
