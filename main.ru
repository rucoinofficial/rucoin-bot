import logging
import requests
from telegram import Update, InlineKeyboardButton, InlineKeyboardMarkup
from telegram.ext import Application, CommandHandler, CallbackQueryHandler, ContextTypes

TOKEN = "8843970944:AAF5p3m7deJNG_6dYAElRbk2n6aCtR8KlVg"
CONTRACT = "0x4d870Ae52e61d4FB6e125f4380cC0c0F9f15A575"
NETWORK = "polygon_pos"
BUY_URL = f"https://dapp.quickswap.exchange/#/swap?outputCurrency={CONTRACT}"
SITE_URL = "https://rucoinofficial.github.io/rucoin"
TG_URL = "https://t.me/RuCoin_RUS"
GECKO_URL = f"https://api.geckoterminal.com/api/v2/networks/{NETWORK}/tokens/{CONTRACT}"

logging.basicConfig(level=logging.INFO)

def get_price():
    try:
        r = requests.get(GECKO_URL, timeout=5)
        data = r.json()
        price = float(data["data"]["attributes"]["price_usd"])
        return f"${price:.6f}"
    except:
        return "Нет данных"

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    keyboard = [
        [InlineKeyboardButton("💎 Купить RuCoin", url=BUY_URL)],
        [InlineKeyboardButton("📊 Текущая цена", callback_data="price")],
        [InlineKeyboardButton("🦊 Добавить в MetaMask", callback_data="metamask")],
        [InlineKeyboardButton("🌐 Сайт", url=SITE_URL),
         InlineKeyboardButton("📢 Канал", url=TG_URL)],
    ]
    await update.message.reply_text(
        "🎮 *Добро пожаловать в RuCoin Bot!*\n\n"
        "RuCoin (RUS) — игровая валюта нового поколения на блокчейне Polygon.\n\n"
        "Выберите действие:",
        parse_mode="Markdown",
        reply_markup=InlineKeyboardMarkup(keyboard)
    )

async def button(update: Update, context: ContextTypes.DEFAULT_TYPE):
    query = update.callback_query
    await query.answer()
    if query.data == "price":
        price = get_price()
        keyboard = [[InlineKeyboardButton("🔙 Назад", callback_data="back")]]
        await query.edit_message_text(
            f"📊 *Текущая цена RuCoin*\n\n💰 Цена: *{price}*\n🌐 Сеть: Polygon\n\n`{CONTRACT}`",
            parse_mode="Markdown",
            reply_markup=InlineKeyboardMarkup(keyboard)
        )
    elif query.data == "metamask":
        keyboard = [[InlineKeyboardButton("🔙 Назад", callback_data="back")]]
        await query.edit_message_text(
            f"🦊 *Добавить RuCoin в MetaMask:*\n\n1️⃣ Откройте MetaMask\n2️⃣ Токены → Импортировать\n3️⃣ Вставьте адрес:\n\n`{CONTRACT}`\n\n4️⃣ Сеть: *Polygon (Chain ID: 137)*",
            parse_mode="Markdown",
            reply_markup=InlineKeyboardMarkup(keyboard)
        )
    elif query.data == "back":
        keyboard = [
            [InlineKeyboardButton("💎 Купить RuCoin", url=BUY_URL)],
            [InlineKeyboardButton("📊 Текущая цена", callback_data="price")],
            [InlineKeyboardButton("🦊 Добавить в MetaMask", callback_data="metamask")],
            [InlineKeyboardButton("🌐 Сайт", url=SITE_URL),
             InlineKeyboardButton("📢 Канал", url=TG_URL)],
        ]
        await query.edit_message_text(
            "🎮 *RuCoin Bot*\n\nВыберите действие:",
            parse_mode="Markdown",
            reply_markup=InlineKeyboardMarkup(keyboard)
        )

def main():
    app = Application.builder().token(TOKEN).build()
    app.add_handler(CommandHandler("start", start))
    app.add_handler(CallbackQueryHandler(button))
    print("Бот запущен!")
    app.run_polling()

if __name__ == "__main__":
    main()
