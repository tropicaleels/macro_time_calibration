# m_matschiner Thu Dec 1 01:21:11 CET 2022

if [ ! -f logcombiner.py ]
then
    wget https://raw.githubusercontent.com/mmatschiner/notothenioid_phylogenomics/master/src/logcombiner.py
fi

# Load modules.
module load Python/3.7.2-GCCcore-8.2.0
module load Beast/2.5.2-GCC-8.2.0-2.31.1

# Make the results directory.
mkdir -p ../res/beast/combined

# List all log and trees files.
ls ../res/beast/reps/r??/*.log > ../res/beast/combined/logs.txt
ls ../res/beast/reps/r??/*.trees > ../res/beast/combined/trees.txt

# Combine all replicate log and trees files into a single one.
python3 logcombiner.py -n 2000 -b 40 ../res/beast/combined/logs.txt ../res/beast/combined/parey_et_al.log
python3 logcombiner.py -n 2000 -b 40 ../res/beast/combined/trees.txt ../res/beast/combined/parey_et_al.trees

# Make maximum-clade-credibility consensensus tre.
treeannotator -b 0 -heights mean ../res/beast/combined/parey_et_al.trees ../res/beast/combined/parey_et_al.tre
