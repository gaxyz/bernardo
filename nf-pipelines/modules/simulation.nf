process AMERICAN_ADMIXED {

    scratch true
    input:
        val sample
    output:
        file("genotypes.vcf"), emit: vcf

    """
    stdpopsim HomSap -g HapMapII_GRCh37 \
                     -s 2020 \
                     -c chr16 \
                     -o out.ts \
                     -d AmericanAdmixture_4B11 \
                        ${sample} ${sample} ${sample} ${sample}

    tskit vcf out.ts > g.vcf 
    echo "tsk_0 tsk_01" > namechange
    bcftools reheader --samples namechange -o genotypes.vcf g.vcf
    """


}







