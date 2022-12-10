# michaelm Sun Nov 27 19:55:08 CET 2022

# Make the results directory.
mkdir -p ../res/alignments/07

# Set thresholds.
min_min_ess=200
max_mut_rate=0.005
max_rate_var=0.5
min_length=1000
min_mean_bpp=0.9

# Read the stats table without header line.
tail -n +2 ../res/tables/alignment_stats.txt > tmp.table.txt
while read line
do
    # Get values from the line.
    align_id=`echo ${line} | tr -s " " | cut -d " " -f 1`
    length=`echo ${line} | tr -s " " | cut -d " " -f 2`
    mean_bpp=`echo ${line} | tr -s " " | cut -d " " -f 6`
    mut_rate=`echo ${line} | tr -s " " | cut -d " " -f 7`
    rate_var=`echo ${line} | tr -s " " | cut -d " "  -f 8`
    min_ess=`echo ${line} | tr -s " " | cut -d " " -f 9`

    if (( $(echo "${min_ess} > ${min_min_ess}" | bc -l) ))
    then
        if (( $(echo "${mut_rate} < ${max_mut_rate}" | bc -l) ))
        then
            if (( $(echo "${rate_var} < ${max_rate_var}" | bc -l) ))
            then
                if (( $(echo "${length} > ${min_length}" | bc -l) ))
                then
                    if (( $(echo "${mean_bpp} > ${min_mean_bpp}" | bc -l) ))
                    then
                        cp ../res/alignments/06/${align_id}/${align_id}.nex ../res/alignments/07
                    fi
                fi
            fi
        fi
    fi
done < tmp.table.txt

# Clean up.
rm -f tmp.table.txt
