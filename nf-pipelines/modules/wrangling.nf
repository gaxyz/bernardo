
process VCF_TO_TPED {


    scratch true
    input:
        file(vcf)
    output:
        path "genotypes.tped", emit: tped

    """
    plink --vcf ${vcf} --recode 12 transpose --out genotypes
    """

}


process ADD_ID_TPED {

    scratch true
    input:
        file(tped)
    output:
        path "genotypes_ID.tped", emit: tped_ID
    
    
    """
#!/usr/bin/env python
file = "${tped}"
counter = 0
with open(file, 'r' ) as tped:
    with open("genotypes_ID.tped", 'w' ) as output:
        for line in tped:
            
            counter += 1
            if counter == 100000:
                break 
            fields = line.rstrip().split()                
            fields[1] = "chr" + fields[0] + "_" + fields[3]
            output.write(" ".join(fields) + '\\n' )
    """
}



process SPLIT_TPED {
    
    input:
        file(tped)
        val window_size
        val window_offset
    output:
        path "genotypes_split_*.tped"

    """
    split_tped.py ${tped} ${window_size} ${window_offset}
    """

}



process AVERAGE_LDMAP {

    input:
        file(ldmap)
    output:
        path "ldmap_averaged.txt"
    
    """
    average_ldmap.py genotypes_split ldmap_averaged.txt 
    """
}
