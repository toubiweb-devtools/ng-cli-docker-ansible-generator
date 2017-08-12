FROM node:{{ app.frontend.docker.node_version }}

# install common tools
ENV CORE_PACKAGES bash wget vim git sudo

# install via APT
RUN apt-get update && \
    apt-get install -q -y -o Acquire::Retries=10 $CORE_PACKAGES && \
# immediately remove temporary files
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# sexy bash prompt: https://github.com/twolfson/sexy-bash-prompt
RUN (cd /tmp && git clone --quiet --depth 1 --config core.autocrlf=false https://github.com/twolfson/sexy-bash-prompt && cd sexy-bash-prompt && make --quiet install && rm -rf /tmp/sexy-bash-prompt/ && cp ~/.bash_prompt /etc/bash.sexy-bash-prompt && echo '. /etc/bash.sexy-bash-prompt' >> /etc/bash.bashrc)

# ls colors: https://github.com/trapd00r/LS_COLORS
RUN wget --quiet https://raw.github.com/trapd00r/LS_COLORS/master/LS_COLORS -O /etc/bash.dircolors && echo 'eval $(dircolors -b /etc/bash.dircolors)' >> /etc/bash.bashrc

# force color to be displayed by node: https://github.com/chalk/chalk/issues/79
ENV FORCE_COLOR=1

# set default working directory
WORKDIR /app

# RUN npm install -g npm@{{ app.frontend.docker.npm_version }}
# https://github.com/npm/npm/issues/16807#issuecomment-313591975
RUN yarn global add npm@{{ app.frontend.docker.npm_version }}

# @see: https://github.com/npm/npm/issues/17431
RUN npm install -g --unsafe-perm @angular/cli@{{ app.frontend.docker.ngcli_version }}

# allow 'node' user to go sudo without password
RUN adduser node sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# set default docker user
USER node

# set default working directory
WORKDIR /app
