FROM alpine:3.10

ENV CT_USER_NAME="dev" \
    CT_USER_GROUP="dev" \
    CT_USER_HOME="/home/dev"

# PACKAGES of the container
ENV PACKAGES="\
      shadow \
      dumb-init \
      tzdata \
      python3 \
      libxml2 \
      libxslt \
      libffi \
      openssl \
      util-linux \
      sudo \
      docker \
      bash \
    "
# PACKAGES needed to built python packages
ENV PYTHON_BUILD_PACKAGES="\
      make \
      libc-dev \
      gcc \
      python3-dev \
      libxml2-dev \
      libxslt-dev \
      libffi-dev \
      openssl-dev \
    "

# Add the packages, with a CDN-breakage fallback if needed
RUN apk add --no-cache $PACKAGES || \
        (sed -i -e 's/dl-cdn/dl-4/g' /etc/apk/repositories && apk add --no-cache $PACKAGES)

# Add packages just for the python build process with a CDN-breakage fallback if needed
RUN apk add --no-cache --virtual .build-deps $PYTHON_BUILD_PACKAGES || \
        (sed -i -e 's/dl-cdn/dl-4/g' /etc/apk/repositories && apk add --no-cache --virtual .build-deps $PYTHON_BUILD_PACKAGES)

RUN ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime

# User creation
RUN useradd --create-home --home-dir $CT_USER_HOME $CT_USER_NAME --shell /bin/bash\
    && chmod 750 $CT_USER_HOME \
	&& chown -R $CT_USER_NAME:$CT_USER_GROUP $CT_USER_HOME \
	&& usermod -a -G docker $CT_USER_NAME \
	&& echo "$CT_USER_NAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Remove build dependencies and any leftover apk cache
#RUN apk del --no-cache --purge .build-deps ;\
#    rm -rf /var/cache/apk/* ;\
#    rm -rf ~/.cache/pip/*

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
    && echo "alias ls='ls --color=auto'" >>  $CT_USER_HOME/.bashrc\
    && echo "alias ll='ls -lah'" >>  $CT_USER_HOME/.bashrc\
    && echo "source venv/bin/activate" >>  $CT_USER_HOME/.bashrc\
    && echo "###############################################################################" >>  $CT_USER_HOME/.bashrc \
    && bash venv/bin/activate ;\
    venv/bin/pip3 install -U pip ;\
    venv/bin/pip install docker-compose

ENTRYPOINT ["bash"]


