#!/bin/bash

conda activate

# fix permissions
sudo chown jupyter:jupyter $HOME/Workspace

cd $HOME/Workspace
jupyter lab \
    --ip=0.0.0.0 \
    --port=$PORT \
    --no-browser \
    --NotebookApp.token=$JUPYTERLAB_TOKEN
