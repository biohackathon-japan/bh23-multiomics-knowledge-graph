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
We develop an OMOP SPARQL endpoint using:
- ONTOP: https://ontop-vkg.org
- Mapheator: https://github.com/oeg-upm/mapeathor
- RLM/ShML: https://github.com/herminiogg/ShExML/
    
Clinical data for research is frequently modeled following the [OMOP Common Data Model](https://ohdsi.github.io/CommonDataModel/cdm54.html). The OMOP-CDM provides not only a data model but also a graph like structure of concepts and their relationships that leverages widely accepted clinical coding systems such as SNOMED CT, RxNorm, LOINC, and ICD-10, among others. It would make sense to enable querying an OMOP-CDM resource using SPARQL so that it could be easily integrated with other resources. Instead of replicating the data in a different endpoint we can make use of [ontop](https://ontop-vkg.org), a Virtual Knowledge Graph system which can expose the content of arbitrary relational databases as knowledge graphs. These graphs are virtual, which means that data remains in the data sources instead of being moved to another database.

Ontop translates SPARQL queries (opens new window) expressed over the knowledge graphs into SQL queries executed by the relational data sources. It relies on R2RML mappings (opens new window) and can take advantage of lightweight ontologies.

  

    

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
