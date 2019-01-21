# pseudogene / busco-docker

[![Docker Pulls](https://img.shields.io/docker/pulls/pseudogene/busco-docker.svg)](https://hub.docker.com/r/pseudogene/busco-docker/)
[![Layers](https://images.microbadger.com/badges/image/pseudogene/busco-docker.svg)](https://microbadger.com/images/pseudogene/busco-docker)


Docker container run environment for BUSCO (_Benchmarking Universal Single-Copy Orthologs_)

> About BUSCO
> BUSCO v3 provides quantitative measures for the assessment of genome assembly, gene set, and transcriptome completeness, based on evolutionarily-informed expectations of gene content from near-universal single-copy orthologs selected from OrthoDB v9.
>
> BUSCO assessments are implemented in open-source software, with a large selection of lineage-specific sets of Benchmarking Universal Single-Copy Orthologs. These conserved orthologs are ideal candidates for large-scale phylogenomics studies, and the annotated BUSCO gene models built during genome assessments provide a comprehensive gene predictor training set for use as part of genome annotation pipelines.
>
> -- http://busco.ezlab.org/


## Usage

To run, mount your input directory with -v, and then use standard run_BUSCO.py commands. For example, to run the proteins annotation check (with `-m proteins`) on a fasta called `seq.faa` in the current directory, use the following:

```bash
docker run \
  --rm -u $(id -u):$(id -g)
  -v "$(pwd)":"/data" \
  pseudogene/busco:latest \
  run_BUSCO.py \
  -in seq.faa \
  -m proteins -o output -m proteins
```

You will probably want to grab the correct lineage profile from the Busco site. For example,
to run with the high-level `fungi` dataset, first download the profile and then pass it as an argument when running.

```bash
lineage=fungi_odb9
wget http://busco.ezlab.org/datasets/$lineage.tar.gz
tar -xzvf $lineage.tar.gz && rm $lineage.tar.gz

docker run \
  --rm -u $(id -u):$(id -g)
  -v "$(pwd)":/data \
  pseudogene/busco:latest \
  run_BUSCO.py \
  --in seq.faa \
  --lineage_path $lineage
  -m proteins -o out_label -m proteins
```

For a complete list of available lineage profiles, see the [full list](http://busco.ezlab.org/frame_wget.html) on the BUSCO site or read the User Guide.

You can also enter the container environment and work within it. All executables, e.g. `run_BUSCO.py`, `generate_plots.py`, are in the `PATH`.

```bash
docker run \
  -it --rm -u $(id -u):$(id -g)
  -v "$(pwd)":/data \
  pseudogene/busco:latest \
  /bin/bash
```

## Reference

For more information, see:

BUSCO: assessing genome assembly and annotation completeness with single-copy orthologs.
Felipe A. Simão, Robert M. Waterhouse, Panagiotis Ioannidis, Evgenia V. Kriventseva, and Evgeny M. Zdobnov
Bioinformatics, published online June 9, 2015 [doi:10.1093/bioinformatics/btv351](https://doi.org/10.1093/bioinformatics/btv351).
