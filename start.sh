#!/bin/bash

mkdir -p /home/jupyter/Workspace
cd /home/jupyter/Workspace
jupyter lab \
    --ip=0.0.0.0 \
    --port=$PORT \
    --no-browser \
    --NotebookApp.token=$JUPYTERLAB_TOKEN \
    --NotebookApp.terminado_settings={'shell_command': ['/usr/bin/bash']}"