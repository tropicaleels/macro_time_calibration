# m_matschiner Mon Jan 3 14:35:19 CET 2022

# Set the account.
acct=nn9883k

# Set the beast directory.
beast_dir=../res/beast/

# Set the xml file.
xml=../res/beast/xml/parey_et_al.xml
xml_base=`basename ${xml}`

# Make the log directory.
mkdir -p ../log/beast

# Make replicate directories.
for rep in r0{1..5}
do
    if [ ! -f ${beast_dir}/reps/${rep}/parey_et_al.xml ]
    then
        mkdir -p ${beast_dir}/reps/${rep}
        cat run_beast.slurm | sed 's/QQQQQQ/parey_et_al/g' | sed 's/2.6.7-GCC-10.3.0-CUDA-11.3.1/2.7.0-GCC-11.3.0-CUDA-11.7.0/g' > ${beast_dir}/reps/${rep}/run_beast.slurm
        cp ${xml} ${beast_dir}/reps/${rep}
    fi
done

# Launch replicate analyses.
home=`pwd`
for rep in r0{1..5}
do
    out=`readlink -f ../log/beast/run_beast_${rep}.out`
    rm -f ${out}
    cd ${beast_dir}/reps/${rep}
    sbatch -A ${acct} -o ${out} run_beast.slurm ${xml_base}
    cd ${home}
done
