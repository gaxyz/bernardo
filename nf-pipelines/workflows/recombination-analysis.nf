nextflow.preview.dsl=2                                                          
workflow {                                                                      
                                                                                
/// Configuration                                                               
outdir = params.outdir                                                          
ldmap = params.ldmap_path                                                       
window_size = params.window_size                                                
window_offset = params.window_offset                                            
                                                                                
/// Include modules                                                             
include { PARALLEL_LDMAP } from '../modules/recombination' 
                                                                                
/// Define workflow                                                             
                                                                                

GENOTYPES( chr_dir )            // Read genotypes                                                                     
PARALLEL_LDMAP( GENOTYPES.out )
  
                                                                                
}          

                                                                                




                                                                                


                                                                                







                                                                                
                                                                                
                           
