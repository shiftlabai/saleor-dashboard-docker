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
