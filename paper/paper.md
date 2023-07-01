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

There is an increasing generation of multiple types of omics data for
individual samples. This multi-omics data can capture phenomena on
multiple different levels and therefore significantly improve our
understanding of processes within biological samples. Multi-omics data
is used in a clinical context for improving personalized medicine, in
model organism research for detailed characterization of biological
states, and even on the level of single cells
(cite)[https://www.nature.com/articles/s12276-020-0420-2] to more
deeply characterize cells.

Multi-omics data integration and analysis involve the integration of different types of biological data, such as genomics, transcriptomics, proteomics, and metabolomics, to gain a comprehensive understanding of biological systems. Several common strategies are employed for multi-omics data integration and analysis:

- Correlation Analysis: This approach involves assessing the pairwise correlations between omics datasets. By examining the co-variation patterns between different types of omics data, researchers can identify relationships and potential regulatory mechanisms.
- Dimensionality Reduction Techniques: Dimensionality reduction techniques, such as principal component analysis (PCA) and independent component analysis (ICA), are used to reduce the high-dimensional nature of omics data. These techniques extract relevant features and capture the major sources of variation within the data, facilitating data integration and visualization.
- Integrative Clustering: Integrative clustering methods aim to identify clusters or subgroups of samples based on the integration of multi-omics data. These techniques consider similarities and dissimilarities across different omics layers, enabling the identification of distinct molecular subtypes or phenotypes.

More recently, autoencoders have been utilized for multi-omics data integration by leveraging their ability to learn a compressed representation or latent space of the input data. Autoencoders are neural network architectures consisting of an encoder and a decoder. The encoder maps the input data to a lower-dimensional latent space, while the decoder reconstructs the original input data from the latent representation.

Graph Convolutional Networks (GCNs) can also be employed for multi-omics data analysis by leveraging the graph structure inherent in the data. GCNs are a type of neural network specifically designed to process and analyze graph-structured data, such as biological networks or interaction networks in multi-omics contexts. 

In this work, we propose the construction of a graph representation where each node represents an entity (e.g., gene, protein, metabolite) and the edges represent relationships or interactions between them. The graph can incorporate multiple omics layers, where each layer corresponds to a specific type of biological entity. We can then apply graph convolutional operations to propagate information through the graph structure. GCNs leverage the graph topology to update the node features based on their neighborhood relationships. This enables capturing local and global patterns within the multi-omics data and allows downstream analysis such as patient classification or biormarker discovery.

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
### Biostudies mapping to knowledge graph:

Biostudy refers to a comprehensive and curated database that stores and provides access to metadata and information related to biological and biomedical research studies. It serves as a centralized repository for a wide range of study-related data. It aims to facilitate data sharing, discovery, and integration in the field of life sciences, allowing researchers to access and explore a wealth of information about various biological studies conducted worldwide. Biostudy mapping to a knowledge graph involves linking and integrating data from the databases into a knowledge graph. These databases contain vast information related to biological and biomedical research studies, including metadata, study designs, experimental data, and more.
The mapping begins by extracting relevant data from the Biostudies database, including study information, keywords, authors, affiliations, experimental variables, and other associated metadata. This data is then transformed and structured in a way that aligns with the schema and ontology of the knowledge graph. Next, the mapped data is integrated into the knowledge graph, which serves as a centralized repository of interconnected knowledge. The knowledge graph represents the relationships and connections between different entities, such as biological concepts, genes, diseases, and more.  Mapping this information to a knowledge graph enables efficient querying and retrieval of specific information by leveraging the graph's rich connections and relationships. Additionally, it facilitates data interoperability and integrates diverse biomedical datasets, enabling comprehensive analysis and discovery of new insights.
### Multiomics data RDF representation definition:

Multiomics data RDF representation refers to defining the structure and format of multiomics data using the Resource Description Framework (RDF). Multiomics data refers to integrating data from multiple omics technologies, such as genomics, transcriptomics, proteomics, and metabolomics, among others, to comprehensively understand biological systems. RDF provides a standardized and flexible framework for representing and linking data on the web. It allows for creating structured knowledge graphs that capture the relationships and connections between different data types. In the context of multiomics data, RDF representation involves defining ontologies, classes, properties, and relationships that accurately capture the various omics datasets and their interdependencies. The RDF representation of multiomics data enables interoperability, data integration, and efficient querying across different omics datasets because it can model and link diverse types of omics data into a unified knowledge graph. With the RDF representation of multiomics data, researchers can leverage the power of semantic web technologies and query the knowledge graph using SPARQL, a query language for RDF data. This allows for complex queries that traverse the relationships between different omics datasets, facilitating advanced data analysis, hypothesis generation, and the discovery of novel insights. In summary, the RDF representation of multiomics data provides a standardized and interoperable approach to integrate and analyze diverse omics datasets.

For correct representation and analysis, it is important to capture the context of omics experimental data captured in the metadata description of biological studies in databases such as BioStudies - [EMBL-EBI](https://www.ebi.ac.uk/biostudies/) and map it to multiomics knowledge graphs. In this regard having the metadata of omics data described in a FAIR way can help researchers to speed up the cumbersome task of constructing knowledge graphs.

## Clinical knowledge graph

Our use case was to explore the use of multilevel omics for the discovery of biomarkers and therapeutic targets for stroke. For this, we focused on a previous study comprising proteomics, transcriptomics, methylation and miRNA expression data for a cohort of 30 stroke patients. We propose an RDF representation for the patient metadata that can be extracted from the Electronic Health Records and integrated into our knowledge graph.

Clinical data for research is frequently modeled following the [OMOP Common Data Model](https://ohdsi.github.io/CommonDataModel/cdm54.html). The OMOP-CDM provides not only a data model but also a graph like structure of concepts and their relationships that leverages widely accepted clinical coding systems such as SNOMED CT, RxNorm, LOINC, and ICD-10, among others. It would make sense to enable querying an OMOP-CDM resource using SPARQL so that it could be easily integrated with other resources. Instead of replicating the data in a different endpoint we can make use of [ontop](https://ontop-vkg.org), a Virtual Knowledge Graph system which can expose the content of arbitrary relational databases as knowledge graphs. These graphs are virtual, which means that data remains in the data sources instead of being moved to another database.

Ontop translates SPARQL queries expressed over the knowledge graphs into SQL queries executed by the relational data sources. It relies on R2RML mappings and can take advantage of lightweight ontologies.

To generate the R2RML mappings we used [ShExML](https://github.com/herminiogg/ShExML/) Shape Expressions Mapping Language (ShExML) is a DSL that offers a solution for mapping and merging heterogeneous data sources. As being based on ShEx the shape is the main foundation to define the transformations.

By exposing a SPARQL endpoint on top of an OMOP-CDM resource using Ontop, several benefits can be achieved. 

1. Semantic Querying: SPARQL is a powerful query language for RDF data, allowing users to express complex queries and retrieve information based on semantic relationships. By providing a SPARQL endpoint, researchers can leverage semantic querying capabilities to explore and analyze the OMOP-CDM data, enabling more sophisticated and precise data retrieval.

2. Integration with Linked Data: The RDF format used in Ontop allows for integration with the broader Linked Data ecosystem. OMOP-CDM data can be linked to other relevant datasets, ontologies, and vocabularies, creating an interconnected network of biomedical knowledge. This integration enables researchers to leverage external resources for enhanced analysis, discovery of new relationships, and enrichment of the research context.

3. Interoperability: The SPARQL endpoint provided by Ontop facilitates interoperability between different systems and tools. Researchers can utilize existing SPARQL-compatible tools, frameworks, and libraries to query and process the OMOP-CDM data. This interoperability enhances the accessibility and usability of the OMOP-CDM resource, making it easier to collaborate and integrate the data into various research workflows.

4. Knowledge Discovery: The semantic representation provided by Ontop allows for enhanced knowledge discovery within the OMOP-CDM data. Researchers can uncover hidden relationships, patterns, and correlations by applying advanced reasoning and inference techniques to the data. This capability supports hypothesis generation, data exploration, and the identification of new research directions.

These benefits empower researchers to explore and analyze the data in a more flexible, comprehensive, and meaningful manner, fostering advanced biomedical research and evidence-based decision-making, and allowed us to integrate clinical data into the graph.

### Clinical NLP

In order to enrich the clinical information added to the graph, we used Natural Language Procesing techniques to extract information from clinical notes. Having established a working environment for NLP, we developed a set of pipelines that incorporated various natural language processing API to extract relevant clinical terms and their relationships from textual data. These terms were then matched and mapped to the corresponding ontology terms, thereby providing a standardized representation of the extracted information and integration with the knowledge graph.

## Machine Learning on knowledge graph

Machine learning on graphs is becoming an ubiquitous task in biology and biomedicine with applications ranging from function prediction to drug repurposing, and knowledge graphs play a key role as sources of graph-structured data. As such a knowledge graph-based integration approach with multi-omics data makes it amenable to be easily exploited by deep learning models such as Graph Neural Networks (GNNs). In recent years, GNNs have been utilized in extracting representations for heterogeneous graphs such as graph convolutional networks (GCN) and generative adversarial networks. During the biohackathon, we investigated several tools and methods for graph learning application on multiomics knowledge graphs: [kGCN: a graph-based deep learning framework for life science](https://github.com/clinfo/kGCN/tree/master), [JAMIE: Joint Variational Autoencoders for multimodal imputation and embedding](https://github.com/daifengwanglab/JAMIE), and the [StellarGraph machine learning library](https://stellargraph.readthedocs.io/en/stable/README.html). In the future, we plan to demonstrate the use of multiomics knowledge graphs using these approaches on several use cases.  

### Use Cases
Enabling machine learning to incorporate information about the structure of multiomics knowledge graphs into the model, opens new avenues to make predictions or discover new patterns using this relational knoweldge for application in new use cases. For example, we can perform graph classification for patient classification. A graph classification task predicts an attribute of each graph in a collection of graphs. Graph classification can also be done as a downstream task from graph representation learning/embeddings, by training a supervised or semi-supervised classifier against the embedding vectors. In the same way, node classification tasks predict an attribute of each node in a graph, which enable to be used for biomarker discovery. Another interesting use case is the use of the node feature prediction task for data imputation. Finally, link prediction to predict an attribute of edges in a graph can be used for instance to predict whether an edge should exist in the graph with application on associations of bioentities such as miRNA-target.      
 

![Caption for BioHackrXiv logo figure](./biohackrxiv.png)

# Future work

Moving forward, there are several areas of potential future work to enhance our project's multi-omics data analysis pltaform. First, exploring further graph networks architectures and optimizing training performance. Additionally, expanding ontology mapping to cover more domains and integrating external data sources would increase the scope of our standardization efforts. Validating and evaluating results against gold-standard multi-omics datasets, involving domain experts, and developing a user-friendly library for researchers to run their own analysis are crucial next steps. These future endeavors will refine and advance our methodology, increasing its impact and adoption in bioinformatics.

## Acknowledgements

We would like to thank the fellow participants at BioHackathon 2023 for their collaboration and constructive advice, which greatly influenced our project. We are grateful to the organizers for providing this platform and the developers of open source language models. Special thanks to our mentors, advisors, and colleagues for their guidance and support. Without their contributions, our project in linked data standardization with LLMs in bioinformatics would not have been possible.

## References

1. 
