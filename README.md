# Multi-omics data integration on knowdledge graphs

## Objective

Integrate multiomics data using knowledge graph and Graph Convolutional Networks

## Team
- Alberto Labarga
- María Gomez
- Robert Hoehndorf
- Nuria Queralt
  
## Outcomes

### Biomedical knowledge graph

We have integrated the following data resources

- Uniprot
- mirDB
- MED-RT
- DisGeNet
- Rhea
- Drugbank (WIP)

to generate a biomedical knowledge graph

![image](https://github.com/alabarga/biohackathon-jp-2023/assets/166339/1c5ccac4-4a40-44af-80f0-7713bf59d4ce)

An updated [visual description of the Knowledge Graph](https://onodo.org/visualizations/242727) is [here](https://onodo.org/visualizations/242727)

The workflow and queries for constructing the knowledge graph is available here.

### Omics data
  - Biostudies mapping to knowledge graph
  - Multiomics data RDF representation definition

### Clinical knowledge graph

- We develop an OMOP SPARQL endpoint using:
  - ONTOP: https://ontop-vkg.org
  - Mapheator: https://github.com/oeg-upm/mapeathor
  - RLM/ShML: https://github.com/herminiogg/ShExML/
- We developed a set of notebooks for benchmarking different clinical NLP extraction tools to enrich EHR structured data with the information contained in clinical texts. The notebooks are available at the [src/nlp/notebooks](src/nlp/notebooks) folder.

### Machine Learning on knowledge graph
For our use case, we integrated the different omics and clinical data with the knowledge graph to create a networkx-based graph representation. We then explore different Graph Neural Networks libraries that could be used for the different biological questions we had.
The libraries we used where

    - StellarGraph: https://github.com/stellargraph/stellargraph#installation
    - KGCN: https://github.com/clinfo/kGCN/

Other technologies leveraged were:
- SPARQLWrapper
- RDFlib
- Networkx

The algorithms proposed for the different use cases are:

    - Patient classification: Graph classification
    - Biomarker prediction: Node classification
    - Data imputation: Node feature prediction
    - Drup reporpousing: Link prediction
    
and the notebooks are available at the [src/gcn/notebooks](src/gcn/notebooks) folder.

Check https://github.com/alabarga/biohackathon-jp-2023/tree/main/multiomics-knowledge-graph for a more detailed view of work done durinh Biohackathon
