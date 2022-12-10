# michaelm Sat Nov 26 15:28:36 CET 2022

# Make the output directory.
mkdir -p ../res/alignments/06

# Load modules.
module purge &> /dev/null
module load Python/3.7.2-GCCcore-8.2.0
module load Ruby/2.6.3-GCCcore-8.2.0

# Make the constraints file.
first_fasta=`ls ../res/alignments/05/*.fa | head -n 1`
cat ${first_fasta} | grep ">" | tr -d ">" | cut -d "[" -f 1 > tmp.species.txt
echo "                <distribution id=\"totalgroup.prior\" spec=\"beast.math.distributions.MRCAPrior\" tree=\"@tree.t:Species\" monophyletic=\"true\">" > tmp.constraints.xml
echo "                    <taxonset id=\"totalgroup\" spec=\"TaxonSet\">" >> tmp.constraints.xml
while read line
do
    echo "                          <taxon idref=\"${line}\"/>" >> tmp.constraints.xml
done < tmp.species.txt
echo "                    </taxonset>" >> tmp.constraints.xml
echo "                    <LogNormal name=\"distr\" meanInRealSpace=\"true\">" >> tmp.constraints.xml
echo "                        <parameter name=\"M\">100.0</parameter>" >> tmp.constraints.xml
echo "                        <parameter name=\"S\">0.1</parameter>" >> tmp.constraints.xml
echo "                    </LogNormal>" >> tmp.constraints.xml
echo "                </distribution>" >> tmp.constraints.xml
cat ${first_fasta} | grep ">" | tr -d ">" | cut -d "[" -f 1 | grep -v xenopus | grep -v gallus > tmp.species.txt
echo "                <distribution id=\"ingroup.prior\" spec=\"beast.math.distributions.MRCAPrior\" tree=\"@tree.t:Species\" monophyletic=\"true\">" >> tmp.constraints.xml
echo "                    <taxonset id=\"ingroup\" spec=\"TaxonSet\">" >> tmp.constraints.xml
while read line
do
    echo "                          <taxon idref=\"${line}\"/>" >> tmp.constraints.xml
done < tmp.species.txt
echo "                    </taxonset>" >> tmp.constraints.xml
echo "                </distribution>" >> tmp.constraints.xml
cat ${first_fasta} | grep ">" | tr -d ">" | cut -d "[" -f 1 | grep -e xenopus -e gallus > tmp.species.txt
echo "                <distribution id=\"outgroup.prior\" spec=\"beast.math.distributions.MRCAPrior\" tree=\"@tree.t:Species\" monophyletic=\"true\">" >> tmp.constraints.xml
echo "                    <taxonset id=\"outgroup\" spec=\"TaxonSet\">" >> tmp.constraints.xml
while read line
do
    echo "                          <taxon idref=\"${line}\"/>" >> tmp.constraints.xml
done < tmp.species.txt
echo "                    </taxonset>" >> tmp.constraints.xml
echo "                </distribution>" >> tmp.constraints.xml

# Clean up.
rm -f tmp.species.txt

# Generate XML input files for beast, for each alignment.
for fasta in ../res/alignments/05/*.fa
do
    fasta_id=`basename ${fasta%.reduced.fa}`
    mkdir -p ../res/alignments/06/${fasta_id}
    cat ${fasta} | cut -d "[" -f 1 > tmp.fasta
    python convert.py tmp.fasta ../res/alignments/06/${fasta_id}/${fasta_id}.nex -f nexus
    rm -f tmp.fasta
    if [ ! -f ../res/alignments/06/${fasta_id}/${fasta_id}.xml ]
    then
        ruby beauti.rb -id ${fasta_id} -n ../res/alignments/06/${fasta_id} -u -o ../res/alignments/06/${fasta_id} -c tmp.constraints.xml -l 25000000
    fi
    cat run_beast.slurm | sed "s/QQQQQQ/${fasta_id}/g" > ../res/alignments/06/${fasta_id}/run_beast.slurm
done

# Clean up.
rm -f tmp.constraints.xml

# Go to each alignment directory and start beast analyses from there.
for xml in ../res/alignments/06/*/*.xml
do
    xml_id=`basename ${xml%.xml}`
    cd ../res/alignments/06/${xml_id}
    if [ ! -f ${xml_id}.log ]
    then
        sbatch run_beast.slurm
    fi
    cd - &> /dev/null
done
