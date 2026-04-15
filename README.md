# Conjiweb Docker

Docker 鐗?Conjiweb锛堝鍣ㄥ寲閮ㄧ讲锛夈€?
## 鐗堟湰

- Docker 鐗堬細`web_Conji_Dock`锛堝綋鍓嶏級
- Native 鐗堬細`web_Conji_native`

## 蹇€熷紑濮?
```bash
git clone git@github.com:stone086/Conjiweb-Docker.git
cd Conjiweb-Docker
cp .env.example .env
docker compose up -d --build
```

鍒涘缓 XMPP 鐢ㄦ埛锛?
```bash
docker exec -it conjiweb-prosody prosodyctl adduser youruser@localhost
```

璁块棶锛?
- Web: `http://鏈嶅姟鍣↖P`
- API: `http://鏈嶅姟鍣↖P:8000/docs`

## 甯哥敤鍛戒护

```bash
docker compose ps
docker compose logs -f
docker compose restart
docker compose down
```

## 杩炰笉涓?GitHub

```bash
curl -I https://github.com
```

濡傛灉澶辫触锛屽厛瑙ｅ喅缃戠粶杩為€氭€у啀閮ㄧ讲銆?