#!/usr/bin/env nextflow
// Command line parameters:
// --guppy_dir  dir 	Path to the guppy output directory containing *_sequencing_summary.txt
// --samplename name 	Sample name
// --resultsDir dir 	Path to the output directory

guppy_ch = Channel.fromPath(params.guppy_dir)

process pycoQC {
  publishDir "${params.resultsDir}/", mode: 'copy'
  input:
    file gd from guppy_ch
  output:
    file "${params.samplename}_pycoqc.html" into pycoqc_outputs

  """
  pycoQC -f "${gd}/*_sequencing_summary.txt" -o "${params.samplename}_pycoqc.html" --min_pass_qual 7 
  """
}

