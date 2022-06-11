#!/bin/sh

# Replace any instance of `__ENV_XXX__` in the source code with the value of the environment variable `XXX`
perl -pi -e "s|__ENV_([A-Z_]+)__|\$ENV{\$1}|g" /app/dashboard/*
