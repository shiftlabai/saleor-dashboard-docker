# Saleor Dashboard Docker

A wrapper around the Saleor Dashboard that allows configuration of environment variables at runtime.

## Getting started

1. Fetch the contents of the saleor-dashboard submodule

    ```sh
    git submodule init
    git submodule update
    ```

    (Or clone the repo with the `--recursive` option.)

2. Build

    ```sh
    docker build -t saleor-dashboard-docker .
    ```

3. Run

    ```sh
    docker run -p 8080:80 -e API_URI=https://my-saleor-api.com/graphql/ saleor-dashboard-docker
    ```
