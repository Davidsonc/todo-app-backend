# TODO App - Node.js

## Como rodar

Clone o repositório e instale as dependências:

```bash
cd todo-app-backend
docker-compose up -d
npm install
cp .env.example .env # ajuste os valores de acordo com o seu ambiente
npm run dev
```

## Docker

Execute os comandos de `build` e `run` ajustando as variáveis de ambiente de acordo com o seu ambiente, por exemplo:

```bash
docker build -t todo-app-backend .
docker run -it --rm -p 5000:5000 -e PORT=5000 -e DATABASE_URL="postgresql://postgres:secret@192.168.1.115:5432/develop?schema=public" todo-app-backend
```
