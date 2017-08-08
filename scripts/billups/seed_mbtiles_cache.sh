#!/bin/bash

function seed_layer {
    ./scripts/tilestache-seed.py --include-path=$PWD --layer=$1 --from-mbtiles $2 --output-directory $PWD/cache 
}

function seed_markers {
    seed_layer markers data/mbtiles/markers.mbtiles
}

function seed_products {
    seed_layer products data/mbtiles/products.mbtiles
}

function seed_choice {
    case $1 in
        "products" )
            seed_products ;;
        "markers" )
            seed_markers ;;
        *) echo "Invalid mbtiles layer" ; exit 1 ;;
    esac
}

function main {
    if [ $# -lt 1 ]; then
        seed_markers
        seed_products
    else
        for layer in $@; do
            seed_choice $layer
        done
    fi
}

main $@
