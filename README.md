# Recombination Studies


This repository contains nextflow and singularity files to perform population genetics simulations and subsequent recombination map calculation.

Simulations are performed using the stdpopsim simulation engine with mostly admixure scenarios. Simulaitons are performed using a coalescent approach (msprime),or alternatively, using the forward-time simulator SLiM.

Recombination maps are estimated using LDMAP.



## Directory structure

`containers` is the dir for building the singularity containers used in this study

`nf-pipelines` contains the nextflow pipelines used in this study, where:

	`modules` contains the nextflow modules (nodes of a pipeline)
	`workflows` contains nexflow workflows (whole pipeline)

`bernardo.yaml` contains directive for building the conda environment for performing this study


## Already done

* Basic nextflow modules and workflow for simulation analysis

* ~~Containerization of workflow for~~ simple and efficient implementation on HPCCs

* Simulation of admixed populations under a standardised model (north american admixture)

* Basic LDMAP pipeline for a single subset of chromosome 16

* LDMAP sliding window approach in a parallelized manner.

* General LDMAP pipeline for computing multiple populations (single chromosome)











 

