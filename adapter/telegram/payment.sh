# Telegram Payment API

. "$_HB/adapter/telegram/core.sh"

tg_sendInvoice()            { _tg_api "sendInvoice"            "$1" "tg.sendInvoice"; }
tg_createInvoiceLink()      { _tg_api "createInvoiceLink"      "$1" "tg.createInvoiceLink"; }
tg_answerShippingQuery()    { _tg_call "answerShippingQuery"   "$(json_obj "shipping_query_id" "$1" "ok" "$2")" >/dev/null; }
tg_answerPreCheckoutQuery() { _tg_call "answerPreCheckoutQuery" "$(json_obj "pre_checkout_query_id" "$1" "ok" "$2")" >/dev/null; }
tg_refundStarPayment()      { _tg_call "refundStarPayment"      "$(json_obj "user_id" "$1" "telegram_payment_charge_id" "$2")" >/dev/null; }
tg_getStarTransactions()    { _tg_api "getStarTransactions"    "$(json_obj "offset" "${1:-0}" "limit" "${2:-100}")" "tg.starTransactions"; }
tg_getMyStarBalance()       { _tg_api "getMyStarBalance"       "{}" "tg.myStarBalance"; }
tg_convertGiftToStars()     { _tg_call "convertGiftToStars"     "$(json_obj "user_id" "$1" "gift_id" "$2")" >/dev/null; }
tg_transferGift()           { _tg_call "transferGift"           "$(json_obj "user_id" "$1" "gift_id" "$2")" >/dev/null; }
tg_upgradeGift()            { _tg_call "upgradeGift"            "$(json_obj "user_id" "$1" "gift_id" "$2")" >/dev/null; }
