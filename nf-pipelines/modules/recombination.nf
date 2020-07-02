process LDMAP {

    publishDir "${params.outdir}/results/ldmap" 
    tag "LDMAP"    

    input:
        file(tped)

    output:
        file("ldmap.map"), emit: ldmap_map
        file("ldmap.log"), emit: ldmap_log

    """
    ldmapper1 ${tped} intermediate.tmp job.job ldmap.map ldmap.log 0.05 0.001
    """


}
