process LDMAP {

    publishDir "${params.outdir}/results/ldmap" 
    tag "LDMAP"    

    input:
        file(tped)

    output:
        path "ldmap.map"
        path "ldmap.log"

    """
    echo "PA(E=0.009424,M=0.5)
IT(E)
IT(E,M)
IT(E,M)
CC" > job.job    

    ${params.ldmap} ${tped} \
                                                                  intermediate.tmp \
                                                                  job.job \
                                                                  ldmap.map \
                                                                  ldmap.log \
                                                                  0.05 \
                                                                  0.001
    """


}
