# docker build --tag debian-9 .
# docker container run -it -v /var/run/docker.sock:/var/run/docker.sock debian-9:latest

FROM debian:9-slim

ENV DEBIAN_FRONTEND="noninteractive" \
    APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE="True" \
    CT_USER_NAME="dev" \
    CT_USER_GROUP="dev" \
    CT_USER_HOME="/home/dev"

# PACKAGES of the container
ENV PACKAGES="\
    locales \
    systemd \
    sudo \
    python3 \
    python3-venv \
    "

RUN apt-get update && apt-get upgrade && apt-get dist-upgrade

RUN apt-get install --no-install-recommends -y $PACKAGES

RUN sed -i -e 's/# fr_FR.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/' /etc/locale.gen \
 && dpkg-reconfigure --fronted=$DEBIAN_FRONTEND locales \
 && update-locale LANG=fr_FR.UTF-8

ENV LANG fr_FR.utf8

# Add Docker’s official GPG key and repository:
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get install --no-install-recommends -y docker-ce docker-ce-cli containerd.io \
    && /lib/systemd/systemd-sysv-install enable docker \
    && systemctl enable docker

# Remove installation packages
RUN apt-get autoremove \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/*

# User creation
RUN useradd --create-home --home-dir $CT_USER_HOME $CT_USER_NAME \
    && chmod 750 $CT_USER_HOME \
	&& chown -R $CT_USER_NAME:$CT_USER_GROUP $CT_USER_HOME \
	&& usermod -a -G audio,video,docker,sudo $CT_USER_NAME \
	&& echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Setting
ENV HOME=$CT_USER_HOME \
    USER=$CT_USER_NAME \
    PS1='\u@\h:\W \$ ' \
    HISTTIMEFORMAT="%d/%m/%y %T "

WORKDIR $HOME
USER $CT_USER_NAME

RUN python3 -m venv venv \
    && echo "###############################################################################" >>  $CT_USER_HOME/.bashrc\
    && echo "alias docker='sudo docker'" >>  $CT_USER_HOME/.bashrc\
    && echo "alias docker-compose='sudo $HOME/venv/bin/docker-compose'" >>  $CT_USER_HOME/.bashrc\
    && echo "source venv/bin/activate" >>  $CT_USER_HOME/.bashrc\
    && echo "###############################################################################" >>  $CT_USER_HOME/.bashrc\
    && bash venv/bin/activate ;\
    venv/bin/pip3 install -U pip ;\
    venv/bin/pip install docker-compose

ENTRYPOINT ["bash"]