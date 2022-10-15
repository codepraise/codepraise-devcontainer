ARG IMAGE
FROM ${IMAGE}

RUN \
apt update \
&& apt upgrade -y \
&& apt-get install -y sudo \
&& apt-get install -y vim \
&& rm -rf /var/lib/apt/lists/* \
&& wget https://github.com/mikefarah/yq/releases/download/v4.28.1/yq_linux_amd64.tar.gz -O - |\
  tar xz && mv yq_linux_amd64 /usr/bin/yq

COPY load_profile.sh /etc/profile.d/load_profile.sh
RUN chmod +x /etc/profile.d/load_profile.sh

ARG USERNAME
ARG USER_UID=1000
ARG USER_GID=${USER_UID}
ARG PASSWD

RUN groupadd --gid ${USER_GID} ${USERNAME} \
&& useradd -s /bin/bash --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} \
&& usermod -aG sudo ${USERNAME} \
&& echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/add_sudoers \
&& chmod 0440 /etc/sudoers.d/add_sudoers
