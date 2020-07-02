
process VCF_TO_PED {
    
    scratch true
    input:
        file(vcf)
    output:
        file("*.tped")

    """
    plink --vcf ${vcf} --recode transpose --out genotypes
    """

}
