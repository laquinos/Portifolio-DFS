FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=pt_BR.UTF-8
ENV LANGUAGE=pt_BR:pt_BR
ENV LC_ALL=pt_BR.UTF-8

# Instalar dependências básicas e configurações
RUN apt-get update && apt-get install -y \
    locales \
    curl \
    wget \
    gnupg2 \
    software-properties-common \
    tzdata \
    lsb-release \
    build-essential \
    libssl-dev \
    vim \
    netcat \
    dos2unix \
    && locale-gen pt_BR.UTF-8 \
    && ln -fs /usr/share/zoneinfo/America/Manaus /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata

# Python 3.10 e dependências
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && apt-get install -y \
    python3.10 \
    python3.10-venv \
    python3.10-dev \
    python3-pip \
    python3-dev \
    libmariadb-dev \
    libmariadb-dev-compat \
    pkg-config \
    libcairo2-dev \
    libgirepository1.0-dev \
    gir1.2-gtk-3.0 \
    python3-gi \
    libdbus-1-dev \
    libdbus-glib-1-dev \
    libsystemd-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*


RUN apt-get update && apt-get install -y \
    python3-apt \
    python3-distro-info \
    ufw \
    unattended-upgrades


# Instalar Node.js 22.15.0 via nvm
ENV NVM_DIR=/root/.nvm
ENV NODE_VERSION=22.15.0
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && \
    . "$NVM_DIR/nvm.sh" && \
    nvm install $NODE_VERSION && \
    nvm use $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    npm install -g npm@11.4.2

# Tornar Node e npm disponíveis no path do sistema
ENV PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Criação do diretório da aplicação
RUN mkdir -p /app/logs
WORKDIR /app
COPY . /app

# Instalar dependências necessárias para compilar PyGObject e pycairo
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    python3-dev \
    libgirepository1.0-dev \
    libcairo2-dev \
    python3-cairo \
    libatk1.0-dev \
    libpango1.0-dev \
    meson \
    ninja-build


# Instalar dependências Python
RUN pip3 install --no-cache-dir -r requirements.txt

# Instalar servidores ASGI
RUN pip3 install --no-cache-dir uvicorn gunicorn uvloop httptools

EXPOSE 8000

CMD ["uvicorn", "SIEP.asgi:application", "--host", "0.0.0.0", "--port", "8000", "--loop", "uvloop", "--http", "h11", "--interface", "asgi3", "--no-access-log", "--backlog", "4096", "--timeout-keep-alive", "1500", "--timeout-graceful-shutdown", "1500"]
