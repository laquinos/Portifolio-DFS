FROM python:3.12-slim

# --- Instala dependências do sistema ---
RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    default-libmysqlclient-dev \
    curl \
    gnupg \
    build-essential \
    npm \
    pkg-config \
    && apt-get clean

# --- Diretório de trabalho ---
WORKDIR /app

# --- Copia o requirements.txt e instala dependências Python ---
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# --- Copia o restante do projeto ---
COPY . .

# --- Instala dependências do Tailwind ---
WORKDIR /app/theme/static_src/
RUN npm install

# --- Volta para o projeto principal ---
WORKDIR /app

# --- Expondo a porta padrão do Django ---
EXPOSE 9000

# --- Comando padrão para desenvolvimento com Tailwind ---
CMD ["python", "manage.py", "tailwind", "dev"]
