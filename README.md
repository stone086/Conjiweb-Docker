# Conjiweb Docker

Conjiweb 的 Docker 部署版。

## 版本

- Docker 版：`Conjiweb-Docker`（当前）
- Native 版：`Conjiweb`

## 快速开始

```bash
git clone https://github.com/stone086/Conjiweb-Docker.git
cd Conjiweb-Docker
cp .env.example .env
docker compose up -d --build
```

## 创建 XMPP 用户

```bash
docker exec -it conjiweb-prosody prosodyctl adduser youruser@localhost
```

## 访问地址

- Web: `http://服务器IP`
- API: `http://服务器IP:8000/docs`

## 常用命令

```bash
docker compose ps
docker compose logs -f
docker compose restart
docker compose down
```
