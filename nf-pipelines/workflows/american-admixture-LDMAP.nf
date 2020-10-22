nextflow.preview.dsl=2
workflow {

/// Configuration
sample = params.sample_number
outdir = params.outdir
ldmap = params.ldmap_path
window_size = params.window_size
window_offset = params.window_offset

/// Include modules


include { AMERICAN_ADMIXED } from '../modules/simulation' params(sample:sample)
include { VCF_TO_TPED } from '../modules/wrangling'
include { ADD_ID_TPED } from '../modules/wrangling'
include { LDMAP } from '../modules/recombination' params(outdir:outdir, ldmap:ldmap)
include { AVERAGE_LDMAP } from '../modules/wrangling'
include { SPLIT_TPED } from '../modules/wrangling'
    
/// Define workflow

AMERICAN_ADMIXED( sample ) /// Should output VCF file and sumary file

/// SUMMARIZE_SIMULATION( AFRICAN_ADMIXED.out.summary ) /// Could be more than one file iDK

VCF_TO_TPED( AMERICAN_ADMIXED.out.vcf ) /// convert VCF output to TPED format
ADD_ID_TPED( VCF_TO_TPED.out.tped ) /// modify SNP id on tped file


SPLIT_TPED( ADD_ID_TPED.out.tped_ID, window_size, window_offset )/// Split into genome pieces for parallelization

LDMAP( SPLIT_TPED.out ) /// Apply LDMAP to each genome piece

AVERAGE_LDMAP( LDMAP.out.collect()) /// Post-process: average results.


}

