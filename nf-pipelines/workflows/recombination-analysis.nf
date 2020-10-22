nextflow.preview.dsl=2                                                          
workflow {                                                                      
                                                                                
/// Configuration                                                               
outdir = params.outdir                                                          
ldmap = params.ldmap_path                                                       
window_size = params.window_size                                                
window_offset = params.window_offset                                            
                                                                                
/// Include modules                                                             
include { LDMAP } from '../modules/recombination' params(outdir:outdir, ldmap:ldmap)
include { AVERAGE_LDMAP } from '../modules/wrangling'                           
include { SPLIT_TPED } from '../modules/wrangling'                              
                                                                                
/// Define workflow                                                             
                                                                                

GENOTYPES( chr_dir )            // Read genotypes                                                                     
                                                                                
SPLIT_TPED( GENOTYPES.out, window_size, window_offset )/// Split into genome pieces for parallelization
                                                                                
LDMAP( SPLIT_TPED.out ) /// Apply LDMAP to each genome piece                    
                                                                                
AVERAGE_LDMAP( LDMAP.out.collect() ) /// Post-process: average results.          
                                                                                
                                                                                
}          

                                                                                




                                                                                


                                                                                







                                                                                
                                                                                
                           
