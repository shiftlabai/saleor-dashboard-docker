# Saleor Dashboard Docker

[Saleor Dashboard](https://github.com/saleor/saleor-dashboard)'s [Dockerfile](https://github.com/saleor/saleor-dashboard/blob/main/Dockerfile) expects environment variables such as `API_URI` to be passed at build time, meaning that Docker images have the GraphQL API URI hard-coded into them.

This repo builds a saleor-dashboard Docker image that allows configuration of all environment variables at _runtime_, rather than at build time.

## Getting started

1. Fetch the contents of the saleor-dashboard submodule

    ```sh
    git submodule init
    git submodule update
    ```

    (Or clone this repo with the `--recursive` option.)

2. Build

    ```sh
    ./build.sh
    ```

3. Run

    ```sh
    docker run -p 8080:80 -e API_URI=https://my-saleor-api.com/graphql/ saleor-dashboard:3.0
    ```

## Building a different version

Pass the version of the Saleor dashboard you want to build as an argument to `build.sh`. For example:

```sh
./build.sh 3.1
```
