nextflow.preview.dsl=2
workflow {

/// Configuration
sample = params.sample_number
outdir = params.outdir
ldmap = params.ldmap_path

/// Include modules


include { AMERICAN_ADMIXED } from '../modules/simulation' params(sample:sample)
include { VCF_TO_TPED } from '../modules/wrangling'
include { ADD_ID_TPED } from '../modules/wrangling'
include { LDMAP } from '../modules/recombination' params(outdir:outdir, ldmap:ldmap)

/// Define workflow

AMERICAN_ADMIXED( sample ) /// Should output VCF file and sumary file

/// SUMMARIZE_SIMULATION( AFRICAN_ADMIXED.out.summary ) /// Could be more than one file iDK

VCF_TO_TPED( AMERICAN_ADMIXED.out.vcf ) ///
ADD_ID_TPED( VCF_TO_TPED.out.tped ) ///

LDMAP( ADD_ID_TPED.out.tped_ID ) /// Output to results, maybe add post procesisng module
 
}

