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


process PARALLEL_LDMAP {

    publishDir "results", pattern: "${id}.map"

    label 'big'    
 
    input:
        tuple val(id),file(tped)
    output:
        tuple val(id), file("${id}.map")
        file("*.log")
        file("*")

    """
    split-tped.py $tped $id $params.window_size $params.window_offset 
    parallel-ldmap.py $params.ldmap $id $task.cpus 
    average-ldmap.py $id ldmap_averaged_${id}.map
    order-ldmap.py ldmap_averaged_${id}.map $tped ${id}.map
    """


}

