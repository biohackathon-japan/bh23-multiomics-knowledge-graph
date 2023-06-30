---
title: 'BioHackJP 2023 Report R4: Clinical Knowledge Graph'
title_short: 'BioHackJP 2023 LD-LLM'
tags:
  - Clinical Knowledge Graph
  - Multi-omics data analysis
authors:
  - name: First Author
    orcid: 0000-0000-0000-0000
    affiliation: 1
  - name: Last Author
    orcid: 0000-0000-0000-0000
    affiliation: 2
affiliations:
  - name: First Affiliation
    index: 1
  - name: Second Affiliation
    index: 2
date: 30 June 2023
cito-bibliography: paper.bib
event: BH23JP
biohackathon_name: "BioHackathon Japan 2023"
biohackathon_url:   "https://2023.biohackathon.org/"
biohackathon_location: "Kagawa, Japan, 2023"
group: R1
# URL to project git repo --- should contain the actual paper.md:
git_url: https://github.com/biohackathon-japan/bh23-multiomics-knowledge-graph
# This is the short authors description that is used at the
# bottom of the generated paper (typically the first two authors):
authors_short: First Author \emph{et al.}
---

# Background

There is an increasing generating of multiple types of omics data for
individual samples. This multi-omics data can capture phenomena on
multiple different levels and therefore significantly improve our
understanding of processes within biological samples. Multi-omics data
is used in a clinical context for improving personalized medicine, in
model organism research for detailed characterization of biological
states, and even on the level of single cells
(cite)[https://www.nature.com/articles/s12276-020-0420-2] to more
deeply characterize cells.

Multi-omics data is highly dimensional and 

- Personalized medicine can benefit of the knowledge already generated
- Multi-omics data analysis must move from matrices analysis to graph analysis
- Use case: Multilevel omics for the discovery of biomarkers and therapeutic targets for stroke

The field of bioinformatics plays a crucial role in enabling researchers to extract meaningful insights from the vast amount of biological data generated today. With advancements in technology and the availability of large-scale datasets, it has become increasingly important to develop standardized approaches for representing and integrating biological information. Linked data, a method for publishing structured data on the web, has emerged as a promising solution for facilitating the integration and interoperability of diverse biological data sources.

The BioHackathon 2023, held in Japan, provided an ideal platform for researchers and bioinformatics enthusiasts to collaborate and explore innovative solutions to address the challenges in the field. Our project focused on the application of Linked Data and Large Language Models (LLMs) to standardize biological data and enhance its accessibility and usability.

LLMs, such as OpenAI's GPT-3.5 architecture, have demonstrated remarkable capabilities in understanding and generating human-like text. Leveraging the power of LLMs, we aimed to automate the process of extracting relevant biological terms from unstructured text and mapping them to existing ontology terms. Ontologies, which are hierarchical vocabularies of terms and their semantic relationships, provide a standardized framework for organizing and categorizing biological concepts.

# Outcomes

## Knowledge graph for multi-omics data integration

We generated a knowledge graph specifically intended for integrating
multi-omics data. While there are many knowledge graphs for biological
and biomedical data available (Monarch, PheKnowLator, etc.)[...], a
graph for integrating multi-omics data should satisfy certain
requirements. First, nodes should represent biological entities that
can be measured within an omics experiment. While it is, in principle,
possible to add nodes that cannot be measured directly (such as the
functions of genes), these nodes will likely introduce noise in
downstream analyses and should be avoided. Second, all entities that
can be measured by an omics experiments should be represented in the
graph. This principle aims at completeness, i.e., the ability of the
graph to represent all measurements, so that no information is lost
when using the graph. Third, edges should represent meaningful
biological connections. We will use the graph to let information
"flow" between entities, and this flow should capture biological
associations. Desirable edges include relations between transcripts
and proteins into which they will be translated. Undesirable edges
include co-mentions in literature because this co-mention does not
represent a biological relation.

The graph we built is based on Ensembl identifiers as primary means to
identify genes, transcripts, and proteins; it includes chemicals
(metabolites) identified using the ChEBI ontology, diseases
identified using ICD-9, and microRNAs identified using their miRDB
identifier. We obtained most of the relations between the entities
from public databases using SPARQL queries. For example, we used
UniProt to provide the links between the Ensembl identifiers:
```
SELECT ?protein ?transcript ?ensprotein ?gene
WHERE 
{
  ?protein rdfs:seeAlso ?transcript .
  ?protein a up:Protein .
  ?protein up:organism taxon:9606 .
  ?transcript a up:Transcript_Resource .
  ?transcript up:translatedTo ?ensprotein .
  ?transcript up:transcribedFrom ?gene .
}
```
Similarly, we used the Rhea database to identify metabolites and their
relations to proteins:
```
SELECT ?chem ?chemname ?rhea ?reactionSide1 ?equation
WHERE {
  ?chem up:name ?chemname .
  ?rhea rh:substrates ?reactionSide1 .
  ?rhea rh:products ?reactionSide2 .
  ?reactionSide1  rh:contains / rh:compound / rh:chebi ?chem .
  ?reactionSide1 rh:transformableTo ?reactionSide2 .
  ?rhea rh:equation ?equation .
}
```


##  Omics data mapping to the knowledge graph
  - Biostudies mapping to knowledge graph
  - Multiomics data RDF representation definition

For correct representation and analysis, it is important to capture the context of omics experimental data captured in the metadata description of biological studies in databases such as BioStudies - [EMBL-EBI](https://www.ebi.ac.uk/biostudies/) and map it to multiomics knowledge graphs. In this regard having the metadata of omics data described in a FAIR way can help researchers to speed up the cumbersome task of constructing knowledge graphs.

## Clinical knowledge graph

Clinical data for research is frequently modeled following the [OMOP Common Data Model](https://ohdsi.github.io/CommonDataModel/cdm54.html). The OMOP-CDM provides not only a data model but also a graph like structure of concepts and their relationships that leverages widely accepted clinical coding systems such as SNOMED CT, RxNorm, LOINC, and ICD-10, among others. It would make sense to enable querying an OMOP-CDM resource using SPARQL so that it could be easily integrated with other resources. Instead of replicating the data in a different endpoint we can make use of [ontop](https://ontop-vkg.org), a Virtual Knowledge Graph system which can expose the content of arbitrary relational databases as knowledge graphs. These graphs are virtual, which means that data remains in the data sources instead of being moved to another database.

Ontop translates SPARQL queries (opens new window) expressed over the knowledge graphs into SQL queries executed by the relational data sources. It relies on R2RML mappings (opens new window) and can take advantage of lightweight ontologies.

### Clinical NLP

 
To achieve our objectives, we conducted a comprehensive survey of open source language models available and evaluated their suitability for our task. We explored different models, taking into consideration factors such as performance, computational requirements, and ease of deployment. Subsequently, we sought to run the selected models on a local computer, ensuring that the infrastructure requirements were met.

Having established a working environment for LLMs, we developed a set of pipelines that incorporated various natural language processing techniques to extract relevant biological terms from textual data. These terms were then matched and mapped to the corresponding ontology terms, thereby providing a standardized representation of the extracted information. By utilizing Linked Data principles, we aimed to create an interconnected network of biological knowledge that would facilitate data integration and enable advanced analysis.

## Machine Learning on knowledge graph
  - Graph Neural Networks
    - StellarGraph
    - KGCN
  - Use cases
    - Graph classification: Patient classification
    - Node classification: Biomarkers
    - Node feature prediction: Data imputation
    - Link prediction: miRNA target prediction

Machine learning on graphs is becoming an ubiquitous task in biology and biomedicine with applications ranging from function prediction to drug repurposing, and knowledge graphs play a key role as sources of graph-structured data. As such a knowledge graph-based integration approach with multi-omics data makes it amenable to be easily exploited by deep learning models such as Graph Neural Networks (GNNs). In recent years, GNNs have been utilized in extracting representations for heterogeneous graphs such as graph convolutional networks (GCN) and generative adversarial networks. During the biohackathon, we investigated several tools and methods for graph learning application on multiomics knowledge graphs: [kGCN: a graph-based deep learning framework for life science](https://github.com/clinfo/kGCN/tree/master), [JAMIE: Joint Variational Autoencoders for multimodal imputation and embedding](https://github.com/daifengwanglab/JAMIE), and the [StellarGraph machine learning library](https://stellargraph.readthedocs.io/en/stable/README.html). In the future, we plan to demonstrate the use of multiomics knowledge graphs using these approaches on several use cases.  

### Use Cases
Enabling machine learning to incorporate information about the structure of multiomics knowledge graphs into the model, opens new avenues to make predictions or discover new patterns using this relational knoweldge for application in new use cases. For example, we can perform graph classification for patient classification. A graph classification task predicts an attribute of each graph in a collection of graphs. Graph classification can also be done as a downstream task from graph representation learning/embeddings, by training a supervised or semi-supervised classifier against the embedding vectors. In the same way, node classification tasks predict an attribute of each node in a graph, which enable to be used for biomarker discovery. Another interesting use case is the use of the node feature prediction task for data imputation. Finally, link prediction to predict an attribute of edges in a graph can be used for instance to predict whether an edge should exist in the graph with application on associations of bioentities such as miRNA-target.      
 

![Caption for BioHackrXiv logo figure](./biohackrxiv.png)

# Future work

Moving forward, there are several areas of potential future work to enhance our project's linked data standardization with LLMs. First, exploring advanced LLMs and optimizing computational efficiency can improve performance. Additionally, expanding ontology mapping to cover more domains and integrating external data sources would increase the scope of our standardization efforts. Validating and evaluating results against gold-standard datasets, involving domain experts, and developing a user-friendly interface for researchers to interact with the pipelines are crucial next steps. These future endeavors will refine and advance our methodology, increasing its impact and adoption in bioinformatics.

## Acknowledgements

We would like to thank the fellow participants at BioHackathon 2023 for their collaboration and constructive advice, which greatly influenced our project. We are grateful to the organizers for providing this platform and the developers of open source language models. Special thanks to our mentors, advisors, and colleagues for their guidance and support. Without their contributions, our project in linked data standardization with LLMs in bioinformatics would not have been possible.

## References

1. 
