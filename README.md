# Conjiweb Docker

Docker 版 Conjiweb（容器化部署）。

## 版本

- Docker 版：`web_Conji_Dock`（当前）
- Native 版：`web_Conji_native`

## 快速开始

```bash
git clone git@github.com:stone086/Conjiweb-Docker.git
cd Conjiweb-Docker
cp .env.example .env
docker compose up -d --build
```

创建 XMPP 用户：

```bash
docker exec -it wgv3-prosody prosodyctl adduser youruser@localhost
```

访问：

- Web: `http://服务器IP`
- API: `http://服务器IP:8000/docs`

## 常用命令

```bash
docker compose ps
docker compose logs -f
docker compose restart
docker compose down
```

## 连不上 GitHub

```bash
curl -I https://github.com
```

如果失败，先解决网络连通性再部署。
