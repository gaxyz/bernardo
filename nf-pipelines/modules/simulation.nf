process AMERICAN_ADMIXED {

    scratch true
    input:
        val sample
    output:
        file("*.vcf")

    """
    stdpopsim HomSap -g HapMapII_GRCh37 \
                     -s 2020 \
                     -c chr16 \
                     -l 0.05 \
                     -o out.ts \
                     -d AmericanAdmixture_4B11 \
                        ${sample} ${sample} ${sample} ${sample}

    tskit vcf out.ts > genotypes.vcf 
    """


}



process SUMMARIZE_SIMULATION {


}
