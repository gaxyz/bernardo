nextflow.preview.dsl=2                                                          
workflow {                                                                      
                                                                                
/// Configuration                                                               
outdir = params.outdir       
vcfs = params.vcfs     // must be glob                                              
ldmap = params.ldmap                                                       
window_size = params.window_size                                                
window_offset = params.window_offset                                            
min_maf = params.min_maf 
                                                                               
/// Include modules                                                             
include { PREPROCESS ; VCF_TO_TPED } from '../modules/wrangling'
include { PARALLEL_LDMAP } from '../modules/recombination' 

// Channel VCFs

vcf = Channel
        .fromPath(vcfs)
        .map { file -> tuple(file.simpleName, file) }


                                                                                
/// Define workflow                                                             
/// Filter biallelic sites
/// Filter MAF
/// Filter Indels

PREPROCESS( vcf )
VCF_TO_TPED( PREPROCESS.out )            // Read genotypes                                                                     
PARALLEL_LDMAP( VCF_TO_TPED.out )
  
                                                                                
}          

                                                                                




                                                                                


                                                                                







                                                                                
                                                                                
                           
