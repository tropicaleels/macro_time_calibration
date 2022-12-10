# m_matschiner Thu Nov 24 16:11:12 CET 2022

# Import libraries and make sure we're on python 3.
import sys
if sys.version_info[0] < 3:
    print('Python 3 is needed to run this script!')
    sys.exit(0)
import argparse, textwrap, random, os, re, datetime
from subprocess import call

# Parse the command line arguments.
parser = argparse.ArgumentParser(
    formatter_class=argparse.RawDescriptionHelpFormatter,
    description=textwrap.dedent('''\
      %(prog)s
    -----------------------------------------
      Identify the reading frame in an alignment.
    '''))
parser.add_argument(
    'infile',
    nargs='?',
    type=argparse.FileType('r'),
    default=sys.stdout,
    help='The name of an input file in FASTA format.'
    )

# Get the command line arguments.
args = parser.parse_args()
infile = args.infile

# Read the input.
if infile.isatty():
    print('ERROR: No input file specified, and no input piped through stdin!')
    sys.exit(1)
instring = infile.read()
inlines = instring.split('\n')

# Determine the input format.
input_format = None
if inlines[0].strip().lower() == "#nexus":
    input_format = "nexus"
elif inlines[0][0] == ">":
    input_format = "fasta"
elif len(inlines[0].split()) == 2 and int(inlines[0].split()[0]) > 0 and int(inlines[0].split()[1]) > 0:
    input_format = "phylip"

# Parse the input lines.
record_ids = []
record_seqs = []
if input_format == "nexus":
    in_matrix = False
    for line in inlines:
        if line.strip().lower() == 'matrix':
            in_matrix = True
        elif line.strip() == ';':
            in_matrix = False
            in_tree = False
        elif in_matrix and line.strip() != '':
            record_ary = line.split()
            record_ids.append(record_ary[0])
            record_seqs.append(record_ary[1].upper())

elif input_format == "fasta":
    for line in inlines:
        if line.strip() != "":
            if line[0] == ">":
                record_ids.append(line[1:].strip())
                record_seqs.append("")
            elif line.strip() != "":
                record_seqs[-1] = record_seqs[-1].upper() + line.strip()

elif input_format == "phylip":
    ntax = int(inlines[0].split()[0])
    nchar = int(inlines[0].split()[1])
    for line in inlines[1:]:
        if line.strip() != "":
            record_ary = line.split()
            record_ids.append(record_ary[0])
            record_seqs.append(record_ary[1].upper())
    if len(record_ids) < ntax:
        print("ERROR: Found less sequences than specified in the phylip header!")
        sys.exit(1)
    elif len(record_ids) > ntax:
        print("ERROR: Found more sequences than specified in the phylip header!")
        sys.exit(1)
    if len(record_seqs[0]) != nchar:
        print("ERROR: The sequence length does not match the length specified in the phylip header!")

# Initiate variables for counts of stop codons.
stop_codons_1 = 0
stop_codons_2 = 0
stop_codons_3 = 0

# Get the numbers of stop codons per reading frame.
for record_seq in record_seqs:
    pos = 0
    while pos < len(record_seq)-4:
        if record_seq[pos:pos+3] in ["TAG", "TAA", "TGA"]:
            stop_codons_1 += 1
        if record_seq[pos+1:pos+4] in ["TAG", "TAA", "TGA"]:
            stop_codons_2 += 1
        if record_seq[pos+2:pos+5] in ["TAG", "TAA", "TGA"]:
            stop_codons_3 += 1
        pos += 3

# Output the numbers of stop codons in each reading frame.
print(str(stop_codons_1) + "\t" + str(stop_codons_2) + "\t" + str(stop_codons_3))
