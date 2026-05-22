# 🪙 RuCoin Telegram Bot

Официальный бот [@RuCoin_RUS_Bot](https://t.me/RuCoin_RUS_Bot) для токена RuCoin на сети Polygon.

## Возможности

- Текущая цена с GeckoTerminal (с кэшем 60 сек)
- Прямая ссылка на покупку через QuickSwap
- Реквизиты для добавления токена в MetaMask
- Ссылки на сайт и Telegram-канал

## Быстрый старт

```bash
# 1. Клонируйте репозиторий
git clone https://github.com/rucoinofficial/rucoin-bot
cd rucoin-bot

# 2. Создайте виртуальное окружение
python3 -m venv venv
source venv/bin/activate   # Windows: venv\Scripts\activate

# 3. Установите зависимости
pip install -r requirements.txt

# 4. Настройте переменные окружения
cp .env.example .env
# Откройте .env и вставьте BOT_TOKEN от @BotFather

# 5. Запустите бота
python main.py
```

## Переменные окружения (.env)

|Переменная |Обязательно|Описание                       |
|-----------|:---------:|-------------------------------|
|`BOT_TOKEN`|✅          |Токен от @BotFather            |
|`CONTRACT` |—          |Адрес контракта (уже задан)    |
|`NETWORK`  |—          |Сеть GeckoTerminal (уже задана)|
|`SITE_URL` |—          |Ссылка на сайт                 |
|`TG_URL`   |—          |Ссылка на Telegram-канал       |


> ⚠️ **Никогда не коммитьте файл `.env`** — он добавлен в `.gitignore`

## Деплой на сервер (systemd)

```ini
# /etc/systemd/system/rucoin-bot.service
[Unit]
Description=RuCoin Telegram Bot
After=network.target

[Service]
WorkingDirectory=/opt/rucoin-bot
EnvironmentFile=/opt/rucoin-bot/.env
ExecStart=/opt/rucoin-bot/venv/bin/python main.py
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now rucoin-bot
sudo journalctl -u rucoin-bot -f   # логи
```

## Контракт

`0x4d870Ae52e61d4FB6e125f4380cC0c0F9f15A575` · Polygon (MATIC)
