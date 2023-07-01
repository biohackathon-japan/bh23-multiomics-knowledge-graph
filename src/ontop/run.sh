docker run --rm \
           -v $PWD/input:/opt/ontop/input \
           -v $PWD/h2/bin:/opt/ontop/jdbc \
           -e ONTOP_ONTOLOGY_FILE=/opt/ontop/input/university-complete.ttl \
           -e ONTOP_MAPPING_FILE=/opt/ontop/input/university-complete.obda \
           -e ONTOP_PROPERTIES_FILE=/opt/ontop/input/university-complete.docker.properties \
           -p 8181:8080 \
           ontop/ontop
           -d

