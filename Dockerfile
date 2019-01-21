FROM ubuntu:18.04

LABEL description="Busco in a Docker" version="1.0" Vendor="Institute of Aquaculture, University of Stirling"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y wget augustus ncbi-blast+ hmmer r-cran-ggplot2 --no-install-recommends

RUN wget https://gitlab.com/ezlab/busco/-/archive/master/busco-master.tar.gz && \
  tar xfz busco-master.tar.gz && \
  cd busco-master && \
  sed -Ei "s/\/home\/osboxes\/BUSCOVM\/augustus\/augustus-.*\/bin\//path = \/usr\/bin\//g" config/config.ini.default && \
  sed -Ei "s/path = \/home\/osboxes\/BUSCOVM\/augustus\/augustus-.*\/scripts\//path = \/usr\/share\/augustus\/scripts\//g" config/config.ini.default && \
  sed -Ei "s/path = \/home\/osboxes\/BUSCOVM\/hmmer\/hmmer-.*\/binaries\//path = \/usr\/bin\//g" config/config.ini.default && \
  mv config/config.ini.default config/config.ini && \
  python setup.py install && \
  cp scripts/*py /usr/local/bin && \
  cd .. && \
  rm -rf busco-master.tar.gz busco-master

RUN mkdir /datasets && \
    cd /datasets && \
    wget http://busco.ezlab.org/v2/datasets/bacteria_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/proteobacteria_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/rhizobiales_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/betaproteobacteria_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/gammaproteobacteria_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/enterobacteriales_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/deltaepsilonsub_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/actinobacteria_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/cyanobacteria_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/firmicutes_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/clostridia_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/lactobacillales_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/bacillales_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/bacteroidetes_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/spirochaetes_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/tenericutes_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/eukaryota_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/fungi_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/microsporidia_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/dikarya_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/ascomycota_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/pezizomycotina_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/eurotiomycetes_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/sordariomyceta_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/saccharomyceta_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/saccharomycetales_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/basidiomycota_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/metazoa_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/nematoda_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/arthropoda_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/insecta_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/endopterygota_odb9.tar.gz  && \
    wget http://busco.ezlab.org/v2/datasets/hymenoptera_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/diptera_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/vertebrata_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/actinopterygii_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/tetrapoda_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/aves_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/mammalia_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/euarchontoglires_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/laurasiatheria_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/embryophyta_odb9.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/protists_ensembl.tar.gz && \
    wget http://busco.ezlab.org/v2/datasets/alveolata_stramenophiles_ensembl.tar.gz && \
    for f in *.tar.gz; do tar xzf $f; done && \
    rm *.tar.gz

WORKDIR /data/
