# m_matschiner Wed Apr 15 11:32:51 CEST 2020

# Load the ape library.
library(ape)

# Get the command-line arguments.
args <- commandArgs(trailingOnly = TRUE)
innexus_tree_file_name <- args[1]
outnewick_tree_file_name <- args[2]

# Read the tree.
innexus_tree <- read.nexus(innexus_tree_file_name)

# Write the tree to the output file.
write.tree(innexus_tree, file=outnewick_tree_file_name)