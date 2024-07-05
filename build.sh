#!/bin/bash
# clear

banner() {
    echo ""
    echo "  _           _ _     _       _     "
    echo " | |__  _   _(_) | __| |  ___| |__  "
    echo " | '_ \| | | | | |/ _  | / __|  _ \ "
    echo " | |_) | |_| | | | (_| |_\__ \ | | |"
    echo " |_.__/ \__,_|_|_|\__,_(_)___/_| |_|"
    echo ""
}

# Define the usage function
usage() {
    local custom_message="$1"
    if [ -n "$custom_message" ]; then
        echo "$custom_message"
        echo ""
    fi
    echo "Usage: build.sh [OPTIONS] <image_type>"
    echo ""
    echo "Options:"
    echo "  -h, --help               Print this message"
    echo "  -v, --version            Print version"
    echo ""
    echo "Image Types:"
    echo "  latest                   Build an image with apache, php, phpmyadmin and mariadb server"
    echo "  mariadb                  Build an image with mariadb server only"
    echo "  web                      Build an image with apache and php only"
    echo ""
    exit 1
}

# Default message if not provided
MESSAGE="developer did not provide any changes"

# Parse command line options
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -h|--help)
            banner
            usage
            ;;
        -v|--version)
            echo "build.sh version 1.0.0"
            exit 0
            ;;
        *)
            break # Exit the option parsing loop if an argument is not an option
            ;;
    esac
done

# Check if the script was called with arguments
if [ $# -eq 0 ]; then
    banner
    usage
fi

# Check for the image type
case "$1" in
    latest)
        banner
        docker buildx build -t tdim/aio-server:latest -f ./Dockerfile .
        ;;
    mariadb)
        banner
        docker buildx build -t tdim/aio-server:mariadb -f ./Dockerfile.mariadb .
        ;;
    web)
        banner
        docker buildx build -t tdim/aio-server:web -f ./Dockerfile.web .
        ;;
    *)
        banner
        # Invalid image type
        usage "Invalid option or image type: $1"
        exit 1
        ;;
esac
