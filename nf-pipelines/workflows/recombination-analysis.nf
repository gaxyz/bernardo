nextflow.preview.dsl=2                                                          
workflow {                                                                      
                                                                                
/// Configuration                                                               
outdir = params.outdir       
vcf_dir = params.vcf_dir                                                   
ldmap = params.ldmap_path                                                       
window_size = params.window_size                                                
window_offset = params.window_offset                                            
                                                                                
/// Include modules                                                             
include {VCF_TO_TPED} from '../modules/wrangling'
include { PARALLEL_LDMAP } from '../modules/recombination' 
                                                                                
/// Define workflow                                                             
                                                                                
VCF_TO_TPED( vcf_dir )            // Read genotypes                                                                     
PARALLEL_LDMAP( VCF_TO_TPED.out )
  
                                                                                
}          

                                                                                




                                                                                


                                                                                







                                                                                
                                                                                
                           
