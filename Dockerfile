FROM ubuntu:22.04

# add non-root user
ARG USERNAME=jupyter
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ENV HOME=/home/$USERNAME

# create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt update \
    && apt install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

RUN apt update

# add default packages
RUN apt install -y build-essential cmake zsh git vim htop wget curl

# Install miniconda
COPY install_miniconda.sh /tmp/
USER $USERNAME
RUN bash /tmp/install_miniconda.sh
RUN $HOME/.miniconda3/bin/conda init
USER root

# Install pip packages
COPY requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt

# user mode
SHELL ["/bin/bash", "-c"]
WORKDIR $HOME
USER $USERNAME
RUN mkdir -p $HOME/Workspace

ENV PORT=80
EXPOSE 80
ENV JUPYTERLAB_TOKEN=hello-jupyterlab
ENV SHELL=/bin/bash
COPY start.sh /
CMD ["bash", "/start.sh"]
