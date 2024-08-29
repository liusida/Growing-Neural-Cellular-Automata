FROM pytorch/pytorch:2.4.0-cuda12.1-cudnn9-runtime

RUN --mount=type=cache,target=/var/cache/apt \
    set -eu \
    && apt-get update \
    && apt-get install -y \
    git \
    libgl1-mesa-glx \
    libglib2.0-0 \
    build-essential

RUN --mount=type=cache,target=/var/cache/apt \
    set -eu \
    && apt-get install -y \
    net-tools inetutils-ping curl

RUN printf 'CREATE_MAIL_SPOOL=no' >> /etc/default/useradd \
    && mkdir -p /home/runner \
    && groupadd runner \
    && useradd runner -g runner -d /home/runner \
    && chown runner:runner /home/runner

USER runner:runner
VOLUME /home/runner
WORKDIR /home/runner
EXPOSE 8888
ENV CLI_ARGS=""
CMD ["bash","/home/runner/entrypoint.sh"]
