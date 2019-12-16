#!/usr/bin/env nextflow
# Command line parameters:
# --guppy_dir  dir 	Path to the guppy output directory containing *_sequencing_summary.txt
# --samplename name 	Sample name
# --resultsDir dir 	Path to the output directory

process pycoQC {
  singularity.enabled = true
  container="singularity/pycoqc_image.img"
  publishDir "${params.resultsDir}/", mode: 'copy'
  input:
    set val(sample),file(guppy_results) from guppy_outputs_pycoqc
  output:
    file "${params.samplename}_pycoqc.html" into pycoqc_outputs
  when:
    params.qc==true

  """
  pycoQC -f "${params.guppy_dir}/*_sequencing_summary.txt" -o "${params.samplename}_pycoqc.html" --min_pass_qual 7 
  """
}

