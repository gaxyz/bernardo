nextflow.preview.dsl=2
workflow {

/// Configuration
sample = 20
outdir = "."

/// Include modules


include { AMERICAN_ADMIXED } from '../modules/simulation'
include { VCF_TO_TPED } from '../modules/wrangling'
include { ADD_ID_TPED } from '../modules/wrangling'
include { LDMAP } from '../modules/recombination' params(outdir:outdir)

/// Define workflow

AMERICAN_ADMIXED( sample ) /// Should output VCF file and sumary file

/// SUMMARIZE_SIMULATION( AFRICAN_ADMIXED.out.summary ) /// Could be more than one file iDK

VCF_TO_TPED( AMERICAN_ADMIXED.out.vcf ) ///
ADD_ID_TPED( VCF_TO_TPED.out.tped ) ///

LDMAP( ADD_ID_TPED.out.tped_ID ) /// Output to results, maybe add post procesisng module
 
}

