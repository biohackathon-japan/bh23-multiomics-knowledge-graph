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

Clinical data for research is frequently modeled following the [OMOP Common Data Model](https://ohdsi.github.io/CommonDataModel/cdm54.html). The OMOP-CDM provides not only a data model but also a graph like structure of concepts and their relationships
  - OMOP SPARQL endpoint
    - Mapheator: https://github.com/oeg-upm/mapeathor
    - RLM/ShML: https://github.com/herminiogg/ShExML/
    - ONTOP: https://ontop-vkg.org

  - NLP
- Machine Learning on knowledge graph
  - Graph Neural Networks
    - StellarGraph
    - KGCN
  - Use cases
    - Graph classification: Patient classification
    - Node classification: Biomarkers
    - Node feature prediction: Data imputation
    - Link prediction: miRNA target prediction
    - 


- [ ] SPARQL query
- [ ] RDFlib
- [ ] Networkx
- [ ] Map expression data
- [ ] GCN



Check https://github.com/alabarga/biohackathon-jp-2023/tree/main/multiomics-knowledge-graph for a more detailed view of work done durinh Biohackathon
