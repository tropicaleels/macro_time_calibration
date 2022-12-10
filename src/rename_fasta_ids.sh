# m_matschiner Sat Nov 26 01:10:18 CET 2022

# Make the output directory.
mkdir -p ../res/alignments/04

# Set the input and output directories.
input_dir=../res/alignments/03
output_dir=../res/alignments/04

# Rename fasta ids in all alignments.
for fasta in ${input_dir}/*.fa
do
    fasta_base=`basename ${fasta}`
    echo -n "Renaming ${fasta_base}..."
    new_fasta=${output_dir}/${fasta_base}
    cat ${fasta} | sed "s/>ENSXET.*/>xenopus_tropicalis/g" | \
        sed "s/>ENSGAL.*/>gallus_gallus/g" | \
        sed "s/>ENSLOC.*/>lepisosteus_oculatus/g" | \
        sed "s/>ENSXMA.*/>xiphophorus_maculatus/g" | \
        sed "s/>ENSPFO.*/>poecilia_formosa/g" | \
        sed "s/>ENSORL.*/>oryzias_latipes/g" | \
        sed "s/>ENSGAC.*/>gasterosteus_aculeatus/g" | \
        sed "s/>ENSTRU.*/>takifugu_rubripes/g" | \
        sed "s/>ENSTNI.*/>tetraodon_nigroviridis/g" | \
        sed "s/>ENSDAR.*/>danio_rerio/g" | \
        sed "s/>ENSAMX.*/>astyanax_mexicanus/g" | \
        sed "s/>ENSSFO.*/>scleropages_formosus/g" | \
        sed "s/>ENSPKI.*/>paramormyrops_kingsleyae/g" | \
        sed "s/>115.*/>cottoperca_gobio/g" | \
        sed "s/>114.*/>perca_flavescens/g" | \
        sed "s/>ANAN.*/>anguilla_anguilla/g" | \
        sed "s/>MATL.*/>megalops_atlanticus/g" | \
        sed "s/>AAFF.*/>aldrovandia_affinis/g" | \
        sed "s/>AGOR.*/>albula_goreensis/g" | \
        sed "s/>SKAU.*/>synaphobranchus_kaupii/g" | \
        sed "s/>GJAV.*/>gymnothorax_javanicus/g" | \
        sed "s/>CCON.*/>conger_conger/g" | \
        sed "s/>HALG.*/>hiodon_alosoides/" | \
        sed "s/>AGIG.*/>arapaima_gigas/g" | \
        sed "s/>AMCG.*/>amia_calva/g" > ${new_fasta}
    echo " done."
done
