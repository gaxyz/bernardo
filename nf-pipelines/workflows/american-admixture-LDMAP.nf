nextflow.preview.dsl=2
workflow {

/// Configuration
sample = 5
outdir = "."

/// Include modules

include "../modules/simulation" 
include "../modules/wrangling" 
include "../modules/recombination" params(outdir:outdir)


/// Define workflow

AMERICAN_ADMIXED( sample ) /// Should output VCF file and sumary file

/// SUMMARIZE_SIMULATION( AFRICAN_ADMIXED.out.summary ) /// Could be more than one file iDK

VCF_TO_TPED( AFRICAN_ADMIXED.out.vcf ) /// Should output tped

LDMAP( VCF_TO_TPED.out.tped ) /// Output to results, maybe add post procesisng module
 
}

