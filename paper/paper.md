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

There is an increasing generalization of multiple types of omics data for
individual samples. This multi-omics data can capture phenomena on
multiple different levels and, therefore significantly improve our
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
identify genes, transcripts, and proteins; it also includes chemicals
(metabolites, identified using the ChEBI ontology), diseases
(identified using ICD-9), and microRNAs (identified using their miRDB
identifier). 

We obtained most of the
relations between the entities from public databases using SPARQL
queries. 


##  Omics data mapping to the knowledge graph
  - Biostudies mapping to knowledge graph:
    Biostudy refers to a comprehensive and curated database that stores and provides access to metadata and information related to biological and biomedical research studies. It serves as a centralized repository for a wide range of study-related data. It aims to facilitate data sharing, discovery, and integration in the field of life sciences, allowing researchers to access and explore a wealth of information about various biological studies conducted worldwide. Biostudy mapping to a knowledge graph involves linking and integrating data from the databases into a knowledge graph. These databases contain vast information related to biological and biomedical research studies, including metadata, study designs, experimental data, and more.
The mapping begins by extracting relevant data from the Biostudies database, including study information, keywords, authors, affiliations, experimental variables, and other associated metadata. This data is then transformed and structured in a way that aligns with the schema and ontology of the knowledge graph. Next, the mapped data is integrated into the knowledge graph, which serves as a centralized repository of interconnected knowledge. The knowledge graph represents the relationships and connections between different entities, such as biological concepts, genes, diseases, and more.  Mapping this information to a knowledge graph enables efficient querying and retrieval of specific information by leveraging the graph's rich connections and relationships. Additionally, it facilitates data interoperability and integrates diverse biomedical datasets, enabling comprehensive analysis and discovery of new insights.

  - Multiomics data RDF representation definition:
    Multiomics data RDF representation refers to defining the structure and format of multiomics data using the Resource Description Framework (RDF). Multiomics data refers to integrating data from multiple omics technologies, such as genomics, transcriptomics, proteomics, and metabolomics, among others, to comprehensively understand biological systems. RDF provides a standardized and flexible framework for representing and linking data on the web. It allows for creating structured knowledge graphs that capture the relationships and connections between different data types. In the context of multiomics data, RDF representation involves defining ontologies, classes, properties, and relationships that accurately capture the various omics datasets and their interdependencies. The RDF representation of multiomics data enables interoperability, data integration, and efficient querying across different omics datasets because it can model and link diverse types of omics data into a unified knowledge graph. With the RDF representation of multiomics data, researchers can leverage the power of semantic web technologies and query the knowledge graph using SPARQL, a query language for RDF data. This allows for complex queries that traverse the relationships between different omics datasets, facilitating advanced data analysis, hypothesis generation, and the discovery of novel insights. In summary, the RDF representation of multiomics data provides a standardized and interoperable approach to integrate and analyze diverse omics datasets.
    
## Clinical knowledge graph
  - OMOP SPARQL endpoint
    - Mapheator: https://github.com/oeg-upm/mapeathor
    - ONTOP: https://ontop-vkg.org
    - RLM/ShML
  - NLP
## Machine Learning on knowledge graph
  - Graph Neural Networks
    - StellarGraph
    - KGCN
  - Use cases
    - Graph classification: Patient classification
    - Node classification: Biomarkers
    - Node feature prediction: Data imputation
    - Link prediction: miRNA target prediction
 
To achieve our objectives, we conducted a comprehensive survey of open-source language models available and evaluated their suitability for our task. We explored different models, taking into consideration factors such as performance, computational requirements, and ease of deployment. Subsequently, we sought to run the selected models on a local computer, ensuring that the infrastructure requirements were met.

Having established a working environment for LLMs, we developed a set of pipelines that incorporated various natural language processing techniques to extract relevant biological terms from textual data. These terms were then matched and mapped to the corresponding ontology terms, thereby providing a standardized representation of the extracted information. By utilizing Linked Data principles, we aimed to create an interconnected network of biological knowledge that would facilitate data integration and enable advanced analysis.

![Caption for BioHackrXiv logo figure](./biohackrxiv.png)

# Future work

Moving forward, there are several areas of potential future work to enhance our project's linked data standardization with LLMs. First, exploring advanced LLMs and optimizing computational efficiency can improve performance. Additionally, expanding ontology mapping to cover more domains and integrating external data sources would increase the scope of our standardization efforts. Validating and evaluating results against gold-standard datasets, involving domain experts, and developing a user-friendly interface for researchers to interact with the pipelines are crucial next steps. These future endeavors will refine and advance our methodology, increasing its impact and adoption in bioinformatics.

## Acknowledgements

We would like to thank the fellow participants at BioHackathon 2023 for their collaboration and constructive advice, which greatly influenced our project. We are grateful to the organizers for providing this platform and the developers of open source language models. Special thanks to our mentors, advisors, and colleagues for their guidance and support. Without their contributions, our project in linked data standardization with LLMs in bioinformatics would not have been possible.

## References

1.
