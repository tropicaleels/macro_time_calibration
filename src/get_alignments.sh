# m_matschiner Thu Nov 24 15:44:34 CET 2022

# Make a data directory.
mkdir -p ../data/alignments

# Download the data archive from parey et al.
wget https://zenodo.org/record/6414307/files/ElopoOsteo.tar.gz
tar -xzf ElopoOsteo.tar.gz

# Move the alignments.
mv ElopoOsteo/molecular_phylo/output_data/seq_alignments/*.fa ../data/alignments

# Clean up.
rm -r ElopoOsteo
rm ElopoOsteo.tar.gz
