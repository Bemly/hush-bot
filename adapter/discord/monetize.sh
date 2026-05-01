# Discord Monetization API

. "$_HB/adapter/discord/core.sh"

dc_entitlement_list()      { _dc_get "/applications/$1/entitlements"; }
dc_entitlement_get()       { _dc_get "/applications/$1/entitlements/$2"; }
dc_entitlement_consume()   { _dc_api "POST" "/applications/$1/entitlements/$2/consume" "{}"; }
dc_entitlement_create()    { _dc_api "POST" "/applications/$1/entitlements" "$2"; }
dc_entitlement_delete()    { _dc_void "DELETE" "/applications/$1/entitlements/$2"; }
dc_sku_list()              { _dc_get "/applications/$1/skus"; }
dc_subscription_list()     { _dc_get "/skus/$1/subscriptions"; }
dc_subscription_get()      { _dc_get "/skus/$1/subscriptions/$2"; }
