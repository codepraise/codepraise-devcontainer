ARG IMAGE
FROM ${IMAGE}

RUN apt update \
    && apt upgrade -y \
    && apt-get install -y sudo \
    && apt-get install -y vim \
    && apt-get install -y emacs \
    && apt-get install -y zsh \
    && apt-get install -y nodejs \
    && apt-get install -y fonts-powerline \
    && wget https://github.com/mikefarah/yq/releases/download/v4.28.1/yq_linux_amd64.tar.gz -O - |\
       tar xz && mv yq_linux_amd64 /usr/bin/yq \
    && curl https://cli-assets.heroku.com/install.sh | sh \
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Add User
ARG USERNAME
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd -s /bin/bash --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} \
    && usermod -aG sudo ${USERNAME} \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/add_sudoers \
    && chmod 0440 /etc/sudoers.d/add_sudoers

ARG HOME=/home/${USERNAME}
RUN echo "source ${HOME}/workspace/.devcontainer/profile.sh" >> '/etc/zsh/zprofile' \
    && echo "source ${HOME}/.zshrc" >> '/etc/zsh/zshrc' \
    && echo "source ${HOME}/workspace/.devcontainer/login_initialization.sh" >> '/etc/zsh/zlogin'

# Install Oh My Zsh
USER ${USERNAME}

COPY ./zsh_initialization.sh ./zsh_config.yml /tmp/
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended \
    && touch ~/.zshrc \
    && /tmp/zsh_initialization.sh \
    && sudo rm /tmp/zsh_initialization.sh /tmp/zsh_config.yml
