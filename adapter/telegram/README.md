# Telegram Bot API Reference

> Auto-extracted from https://core.telegram.org/bots/api via proxy
> 169 methods, 100% covered in Ayu.Core adapter

**Adapter coverage**: 169/169 methods implemented. Method names match official API exactly (CamelCase).
All implemented as `tg_<method>()` one-liners using `_tg_api` / `_tg_call` helpers.
Optional parameters are omitted from one-liners for brevity; pass additional JSON keys
via `json_obj` builder if needed.


## Bot basics

### close

_No parameters_

### getMe

_No parameters_

### logOut

_No parameters_


## Getting Updates

### getUpdates

| Parameter | Type | Required |
|-----------|------|----------|
| offset | Integer | No |
| limit | Integer | No |
| timeout | Integer | No |
| allowed_updates | Array of String | No |

---

## Incoming Webhook (Update)

Webhook POST payload is a JSON `Update` object via `application/json`. If multiple fields are present, only **one** non-optional field is possible per update.

```json
{
  "update_id": 123456789,
  "message": { ... },
  "callback_query": { ... }
}
```

### Update Fields

| Field | Type | Description |
|-------|------|-------------|
| `update_id` | Integer | Unique update identifier, monotonically increasing |
| `message` | Message | *(optional)* New incoming message — text, photo, sticker, etc. |
| `edited_message` | Message | *(optional)* Edited message |
| `channel_post` | Message | *(optional)* New incoming channel post |
| `edited_channel_post` | Message | *(optional)* Edited channel post |
| `callback_query` | CallbackQuery | *(optional)* Inline button callback |
| `inline_query` | InlineQuery | *(optional)* Inline query |
| `chosen_inline_result` | ChosenInlineResult | *(optional)* Inline result chosen |
| `my_chat_member` | ChatMemberUpdated | *(optional)* Bot's chat member status changed |
| `chat_member` | ChatMemberUpdated | *(optional)* Chat member status changed |
| `chat_join_request` | ChatJoinRequest | *(optional)* Chat join request |
| `chat_boost` | ChatBoostUpdated | *(optional)* Chat boost added or changed |
| `removed_chat_boost` | ChatBoostRemoved | *(optional)* Chat boost removed |
| `poll` | Poll | *(optional)* Poll state change (stopped polls only) |
| `poll_answer` | PollAnswer | *(optional)* User changed poll answer |
| `message_reaction` | MessageReactionUpdated | *(optional)* Reaction changed |
| `message_reaction_count` | MessageReactionCountUpdated | *(optional)* Anonymous reaction count changed |
| `shipping_query` | ShippingQuery | *(optional)* Shipping query (invoices) |
| `pre_checkout_query` | PreCheckoutQuery | *(optional)* Pre-checkout query |
| `purchased_paid_media` | PaidMediaPurchased | *(optional)* Paid media purchased |

---

## Message Object

Sent in `message` / `edited_message` / `channel_post` Update fields.

### Core Fields (always present)

| Field | Type | Description |
|-------|------|-------------|
| `message_id` | Integer | Unique message identifier in this chat |
| `date` | Integer | Unix timestamp the message was sent |
| `chat` | Chat | Chat the message belongs to |
| `from` | User | *(optional)* Sender (may be empty for channel posts) |
| `sender_chat` | Chat | *(optional)* Sender when sent on behalf of a chat |

### Content Type Detection

At most **one** of these fields is present. Use this to detect message type:

| Field | Type | Meaning |
|-------|------|---------|
| `text` | String | Text message |
| `animation` | Animation | GIF animation (also sets `document` field) |
| `audio` | Audio | Audio file |
| `document` | Document | General file |
| `photo` | Array\<PhotoSize\> | Photo (only if `animation` not set) |
| `sticker` | Sticker | Sticker |
| `story` | Story | Forwarded story |
| `video` | Video | Video |
| `video_note` | VideoNote | Video note (round video) |
| `voice` | Voice | Voice message |
| `contact` | Contact | Shared contact |
| `dice` | Dice | Dice with random value |
| `game` | Game | Game |
| `poll` | Poll | Native poll |
| `venue` | Venue | Venue (also sets `location` field) |
| `location` | Location | Shared location |
| `checklist` | Checklist | Checklist |
| `paid_media` | PaidMediaInfo | Paid media |

**caption**: Media messages (photo/video/voice/document/animation/audio) may have `caption` instead of `text`.

### Service Message Fields

| Field | Type | Meaning |
|-------|------|---------|
| `new_chat_members` | Array\<User\> | Members joined group |
| `left_chat_member` | User | Member left group |
| `new_chat_title` | String | Chat title changed |
| `new_chat_photo` | Array\<PhotoSize\> | Chat photo changed |
| `delete_chat_photo` | True | Chat photo deleted |
| `group_chat_created` | True | Group created |
| `supergroup_chat_created` | True | Supergroup created |
| `channel_chat_created` | True | Channel created |
| `message_auto_delete_timer_changed` | MessageAutoDeleteTimerChanged | Auto-delete timer changed |
| `migrate_to_chat_id` | Integer | Group migrated to supergroup |
| `migrate_from_chat_id` | Integer | Group migrated from |
| `pinned_message` | Message | Message was pinned |
| `connected_website` | String | Connected website |
| `successful_payment` | SuccessfulPayment | Payment received |
| `users_shared` | UsersShared | Users shared |
| `chat_shared` | ChatShared | Chat shared |
| `forum_topic_created` | ForumTopicCreated | Forum topic created |
| `forum_topic_closed` | ForumTopicClosed | Forum topic closed |
| `forum_topic_reopened` | ForumTopicReopened | Forum topic reopened |
| `forum_topic_edited` | ForumTopicEdited | Forum topic edited |
| `video_chat_scheduled` | VideoChatScheduled | Video chat scheduled |
| `video_chat_started` | VideoChatStarted | Video chat started |
| `video_chat_ended` | VideoChatEnded | Video chat ended |
| `video_chat_participants_invited` | VideoChatParticipantsInvited | Participants invited |
| `write_access_allowed` | WriteAccessAllowed | Write access allowed |
| `giveaway_created` | GiveawayCreated | Giveaway created |
| `giveaway_completed` | GiveawayCompleted | Giveaway completed |
| `giveaway_winners` | GiveawayWinners | Giveaway winners |

### Additional Content Fields

| Field | Type | Description |
|-------|------|-------------|
| `caption` | String | *(optional)* Caption for media (animation/audio/document/photo/video/voice) |
| `caption_entities` | Array\<MessageEntity\> | *(optional)* Entities in caption |
| `entities` | Array\<MessageEntity\> | *(optional)* Entities in `text` |
| `reply_to_message` | Message | *(optional)* Replied message (no recursive nesting) |
| `forward_origin` | MessageOrigin | *(optional)* Forward origin info |
| `media_group_id` | String | *(optional)* Media group this message belongs to |

### CallbackQuery Object

Sent in `callback_query` Update field.

| Field | Type | Description |
|-------|------|-------------|
| `id` | String | Unique callback query identifier |
| `from` | User | User who pressed the button |
| `message` | Message | *(optional)* Message with the inline keyboard |
| `inline_message_id` | String | *(optional)* Inline message identifier |
| `chat_instance` | String | Global chat identifier |
| `data` | String | *(optional)* Data associated with the callback button |
| `game_short_name` | String | *(optional)* Short name of a Game |


## Webhook

### deleteWebhook

| Parameter | Type | Required |
|-----------|------|----------|
| drop_pending_updates | Boolean | No |

### getWebhookInfo

_No parameters_

### setWebhook

| Parameter | Type | Required |
|-----------|------|----------|
| url | String | Yes |
| certificate | InputFile | No |
| ip_address | String | No |
| max_connections | Integer | No |
| allowed_updates | Array of String | No |
| drop_pending_updates | Boolean | No |
| secret_token | String | No |


## Send

### sendAnimation

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | No |
| direct_messages_topic_id | Integer | No |
| animation | InputFile or String | Yes |
| duration | Integer | No |
| width | Integer | No |
| height | Integer | No |
| thumbnail | InputFile or String | No |
| caption | String | No |
| parse_mode | String | No |
| caption_entities | Array of MessageEntity | No |
| show_caption_above_media | Boolean | No |
| has_spoiler | Boolean | No |
| disable_notification | Boolean | No |
| protect_content | Boolean | No |
| allow_paid_broadcast | Boolean | No |
| message_effect_id | String | No |
| suggested_post_parameters | SuggestedPostParameters | No |
| reply_parameters | ReplyParameters | No |
| reply_markup | InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply | No |

### sendAudio

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | No |
| direct_messages_topic_id | Integer | No |
| audio | InputFile or String | Yes |
| caption | String | No |
| parse_mode | String | No |
| caption_entities | Array of MessageEntity | No |
| duration | Integer | No |
| performer | String | No |
| title | String | No |
| thumbnail | InputFile or String | No |
| disable_notification | Boolean | No |
| protect_content | Boolean | No |
| allow_paid_broadcast | Boolean | No |
| message_effect_id | String | No |
| suggested_post_parameters | SuggestedPostParameters | No |
| reply_parameters | ReplyParameters | No |
| reply_markup | InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply | No |

### sendChatAction

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | No |
| action | String | Yes |

### sendChecklist

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | Yes |
| chat_id | Integer | Yes |
| checklist | InputChecklist | Yes |
| disable_notification | Boolean | No |
| protect_content | Boolean | No |
| message_effect_id | String | No |
| reply_parameters | ReplyParameters | No |
| reply_markup | InlineKeyboardMarkup | No |

### sendContact

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | No |
| direct_messages_topic_id | Integer | No |
| phone_number | String | Yes |
| first_name | String | Yes |
| last_name | String | No |
| vcard | String | No |
| disable_notification | Boolean | No |
| protect_content | Boolean | No |
| allow_paid_broadcast | Boolean | No |
| message_effect_id | String | No |
| suggested_post_parameters | SuggestedPostParameters | No |
| reply_parameters | ReplyParameters | No |
| reply_markup | InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply | No |

### sendDice

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | No |
| direct_messages_topic_id | Integer | No |
| emoji | String | No |
| disable_notification | Boolean | No |
| protect_content | Boolean | No |
| allow_paid_broadcast | Boolean | No |
| message_effect_id | String | No |
| suggested_post_parameters | SuggestedPostParameters | No |
| reply_parameters | ReplyParameters | No |
| reply_markup | InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply | No |

### sendDocument

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | No |
| direct_messages_topic_id | Integer | No |
| document | InputFile or String | Yes |
| thumbnail | InputFile or String | No |
| caption | String | No |
| parse_mode | String | No |
| caption_entities | Array of MessageEntity | No |
| disable_content_type_detection | Boolean | No |
| disable_notification | Boolean | No |
| protect_content | Boolean | No |
| allow_paid_broadcast | Boolean | No |
| message_effect_id | String | No |
| suggested_post_parameters | SuggestedPostParameters | No |
| reply_parameters | ReplyParameters | No |
| reply_markup | InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply | No |

### sendGame

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer | Yes |
| message_thread_id | Integer | No |
| game_short_name | String | Yes |
| disable_notification | Boolean | No |
| protect_content | Boolean | No |
| allow_paid_broadcast | Boolean | No |
| message_effect_id | String | No |
| reply_parameters | ReplyParameters | No |
| reply_markup | InlineKeyboardMarkup | No |

### sendGift

| Parameter | Type | Required |
|-----------|------|----------|
| user_id | Integer | No |
| chat_id | Integer or String | No |
| gift_id | String | Yes |
| pay_for_upgrade | Boolean | No |
| text | String | No |
| text_parse_mode | String | No |
| text_entities | Array of MessageEntity | No |

### sendInvoice

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | No |
| direct_messages_topic_id | Integer | No |
| title | String | Yes |
| description | String | Yes |
| payload | String | Yes |
| provider_token | String | No |
| currency | String | Yes |
| prices | Array of LabeledPrice | Yes |
| max_tip_amount | Integer | No |
| suggested_tip_amounts | Array of Integer | No |
| start_parameter | String | No |
| provider_data | String | No |
| photo_url | String | No |
| photo_size | Integer | No |
| photo_width | Integer | No |
| photo_height | Integer | No |
| need_name | Boolean | No |
| need_phone_number | Boolean | No |
| need_email | Boolean | No |
| need_shipping_address | Boolean | No |
| send_phone_number_to_provider | Boolean | No |
| send_email_to_provider | Boolean | No |
| is_flexible | Boolean | No |
| disable_notification | Boolean | No |
| protect_content | Boolean | No |
| allow_paid_broadcast | Boolean | No |
| message_effect_id | String | No |
| suggested_post_parameters | SuggestedPostParameters | No |
| reply_parameters | ReplyParameters | No |
| reply_markup | InlineKeyboardMarkup | No |

### sendLocation

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | No |
| direct_messages_topic_id | Integer | No |
| latitude | Float | Yes |
| longitude | Float | Yes |
| horizontal_accuracy | Float | No |
| live_period | Integer | No |
| heading | Integer | No |
| proximity_alert_radius | Integer | No |
| disable_notification | Boolean | No |
| protect_content | Boolean | No |
| allow_paid_broadcast | Boolean | No |
| message_effect_id | String | No |
| suggested_post_parameters | SuggestedPostParameters | No |
| reply_parameters | ReplyParameters | No |
| reply_markup | InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply | No |

### sendMediaGroup

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | No |
| direct_messages_topic_id | Integer | No |
| media | Array of InputMediaAudio, InputMediaDocument, InputMediaPhoto and InputMediaVideo | Yes |
| disable_notification | Boolean | No |
| protect_content | Boolean | No |
| allow_paid_broadcast | Boolean | No |
| message_effect_id | String | No |
| reply_parameters | ReplyParameters | No |

### sendMessage

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | No |
| direct_messages_topic_id | Integer | No |
| text | String | Yes |
| parse_mode | String | No |
| entities | Array of MessageEntity | No |
| link_preview_options | LinkPreviewOptions | No |
| disable_notification | Boolean | No |
| protect_content | Boolean | No |
| allow_paid_broadcast | Boolean | No |
| message_effect_id | String | No |
| suggested_post_parameters | SuggestedPostParameters | No |
| reply_parameters | ReplyParameters | No |
| reply_markup | InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply | No |

### sendMessageDraft

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer | Yes |
| message_thread_id | Integer | No |
| draft_id | Integer | Yes |
| text | String | Yes |
| parse_mode | String | No |
| entities | Array of MessageEntity | No |

### sendPaidMedia

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | No |
| direct_messages_topic_id | Integer | No |
| star_count | Integer | Yes |
| media | Array of InputPaidMedia | Yes |
| payload | String | No |
| caption | String | No |
| parse_mode | String | No |
| caption_entities | Array of MessageEntity | No |
| show_caption_above_media | Boolean | No |
| disable_notification | Boolean | No |
| protect_content | Boolean | No |
| allow_paid_broadcast | Boolean | No |
| suggested_post_parameters | SuggestedPostParameters | No |
| reply_parameters | ReplyParameters | No |
| reply_markup | InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply | No |

### sendPhoto

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | No |
| direct_messages_topic_id | Integer | No |
| photo | InputFile or String | Yes |
| caption | String | No |
| parse_mode | String | No |
| caption_entities | Array of MessageEntity | No |
| show_caption_above_media | Boolean | No |
| has_spoiler | Boolean | No |
| disable_notification | Boolean | No |
| protect_content | Boolean | No |
| allow_paid_broadcast | Boolean | No |
| message_effect_id | String | No |
| suggested_post_parameters | SuggestedPostParameters | No |
| reply_parameters | ReplyParameters | No |
| reply_markup | InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply | No |

### sendPoll

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | No |
| question | String | Yes |
| question_parse_mode | String | No |
| question_entities | Array of MessageEntity | No |
| options | Array of InputPollOption | Yes |
| is_anonymous | Boolean | No |
| type | String | No |
| allows_multiple_answers | Boolean | No |
| allows_revoting | Boolean | No |
| shuffle_options | Boolean | No |
| allow_adding_options | Boolean | No |
| hide_results_until_closes | Boolean | No |
| correct_option_ids | Array of Integer | No |
| explanation | String | No |
| explanation_parse_mode | String | No |
| explanation_entities | Array of MessageEntity | No |
| open_period | Integer | No |
| close_date | Integer | No |
| is_closed | Boolean | No |
| description | String | No |
| description_parse_mode | String | No |
| description_entities | Array of MessageEntity | No |
| disable_notification | Boolean | No |
| protect_content | Boolean | No |
| allow_paid_broadcast | Boolean | No |
| message_effect_id | String | No |
| reply_parameters | ReplyParameters | No |
| reply_markup | InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply | No |

### sendSticker

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | No |
| direct_messages_topic_id | Integer | No |
| sticker | InputFile or String | Yes |
| emoji | String | No |
| disable_notification | Boolean | No |
| protect_content | Boolean | No |
| allow_paid_broadcast | Boolean | No |
| message_effect_id | String | No |
| suggested_post_parameters | SuggestedPostParameters | No |
| reply_parameters | ReplyParameters | No |
| reply_markup | InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply | No |

### sendVenue

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | No |
| direct_messages_topic_id | Integer | No |
| latitude | Float | Yes |
| longitude | Float | Yes |
| title | String | Yes |
| address | String | Yes |
| foursquare_id | String | No |
| foursquare_type | String | No |
| google_place_id | String | No |
| google_place_type | String | No |
| disable_notification | Boolean | No |
| protect_content | Boolean | No |
| allow_paid_broadcast | Boolean | No |
| message_effect_id | String | No |
| suggested_post_parameters | SuggestedPostParameters | No |
| reply_parameters | ReplyParameters | No |
| reply_markup | InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply | No |

### sendVideo

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | No |
| direct_messages_topic_id | Integer | No |
| video | InputFile or String | Yes |
| duration | Integer | No |
| width | Integer | No |
| height | Integer | No |
| thumbnail | InputFile or String | No |
| cover | InputFile or String | No |
| start_timestamp | Integer | No |
| caption | String | No |
| parse_mode | String | No |
| caption_entities | Array of MessageEntity | No |
| show_caption_above_media | Boolean | No |
| has_spoiler | Boolean | No |
| supports_streaming | Boolean | No |
| disable_notification | Boolean | No |
| protect_content | Boolean | No |
| allow_paid_broadcast | Boolean | No |
| message_effect_id | String | No |
| suggested_post_parameters | SuggestedPostParameters | No |
| reply_parameters | ReplyParameters | No |
| reply_markup | InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply | No |

### sendVideoNote

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | No |
| direct_messages_topic_id | Integer | No |
| video_note | InputFile or String | Yes |
| duration | Integer | No |
| length | Integer | No |
| thumbnail | InputFile or String | No |
| disable_notification | Boolean | No |
| protect_content | Boolean | No |
| allow_paid_broadcast | Boolean | No |
| message_effect_id | String | No |
| suggested_post_parameters | SuggestedPostParameters | No |
| reply_parameters | ReplyParameters | No |
| reply_markup | InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply | No |

### sendVoice

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | No |
| direct_messages_topic_id | Integer | No |
| voice | InputFile or String | Yes |
| caption | String | No |
| parse_mode | String | No |
| caption_entities | Array of MessageEntity | No |
| duration | Integer | No |
| disable_notification | Boolean | No |
| protect_content | Boolean | No |
| allow_paid_broadcast | Boolean | No |
| message_effect_id | String | No |
| suggested_post_parameters | SuggestedPostParameters | No |
| reply_parameters | ReplyParameters | No |
| reply_markup | InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply | No |


## Forward / Copy

### copyMessage

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | No |
| direct_messages_topic_id | Integer | No |
| from_chat_id | Integer or String | Yes |
| message_id | Integer | Yes |
| video_start_timestamp | Integer | No |
| caption | String | No |
| parse_mode | String | No |
| caption_entities | Array of MessageEntity | No |
| show_caption_above_media | Boolean | No |
| disable_notification | Boolean | No |
| protect_content | Boolean | No |
| allow_paid_broadcast | Boolean | No |
| message_effect_id | String | No |
| suggested_post_parameters | SuggestedPostParameters | No |
| reply_parameters | ReplyParameters | No |
| reply_markup | InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardRemove or ForceReply | No |

### copyMessages

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | No |
| direct_messages_topic_id | Integer | No |
| from_chat_id | Integer or String | Yes |
| message_ids | Array of Integer | Yes |
| disable_notification | Boolean | No |
| protect_content | Boolean | No |
| remove_caption | Boolean | No |

### forwardMessage

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | No |
| direct_messages_topic_id | Integer | No |
| from_chat_id | Integer or String | Yes |
| video_start_timestamp | Integer | No |
| disable_notification | Boolean | No |
| protect_content | Boolean | No |
| message_effect_id | String | No |
| suggested_post_parameters | SuggestedPostParameters | No |
| message_id | Integer | Yes |

### forwardMessages

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | No |
| direct_messages_topic_id | Integer | No |
| from_chat_id | Integer or String | Yes |
| message_ids | Array of Integer | Yes |
| disable_notification | Boolean | No |
| protect_content | Boolean | No |


## Delete

### deleteBusinessMessages

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | Yes |
| message_ids | Array of Integer | Yes |

### deleteChatPhoto

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |

### deleteChatStickerSet

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |

### deleteForumTopic

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | Yes |

### deleteMessage

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| message_id | Integer | Yes |

### deleteMessages

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| message_ids | Array of Integer | Yes |

### deleteMyCommands

| Parameter | Type | Required |
|-----------|------|----------|
| scope | BotCommandScope | No |
| language_code | String | No |

### deleteStickerFromSet

| Parameter | Type | Required |
|-----------|------|----------|
| sticker | String | Yes |

### deleteStickerSet

| Parameter | Type | Required |
|-----------|------|----------|
| name | String | Yes |

### deleteStory

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | Yes |
| story_id | Integer | Yes |


## Edit

### editChatInviteLink

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| invite_link | String | Yes |
| name | String | No |
| expire_date | Integer | No |
| member_limit | Integer | No |
| creates_join_request | Boolean | No |

### editChatSubscriptionInviteLink

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| invite_link | String | Yes |
| name | String | No |

### editForumTopic

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | Yes |
| name | String | No |
| icon_custom_emoji_id | String | No |

### editGeneralForumTopic

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| name | String | Yes |

### editMessageCaption

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | No |
| message_id | Integer | No |
| inline_message_id | String | No |
| caption | String | No |
| parse_mode | String | No |
| caption_entities | Array of MessageEntity | No |
| show_caption_above_media | Boolean | No |
| reply_markup | InlineKeyboardMarkup | No |

### editMessageChecklist

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | Yes |
| chat_id | Integer | Yes |
| message_id | Integer | Yes |
| checklist | InputChecklist | Yes |
| reply_markup | InlineKeyboardMarkup | No |

### editMessageLiveLocation

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | No |
| message_id | Integer | No |
| inline_message_id | String | No |
| latitude | Float | Yes |
| longitude | Float | Yes |
| live_period | Integer | No |
| horizontal_accuracy | Float | No |
| heading | Integer | No |
| proximity_alert_radius | Integer | No |
| reply_markup | InlineKeyboardMarkup | No |

### editMessageMedia

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | No |
| message_id | Integer | No |
| inline_message_id | String | No |
| media | InputMedia | Yes |
| reply_markup | InlineKeyboardMarkup | No |

### editMessageReplyMarkup

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | No |
| message_id | Integer | No |
| inline_message_id | String | No |
| reply_markup | InlineKeyboardMarkup | No |

### editMessageText

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | No |
| message_id | Integer | No |
| inline_message_id | String | No |
| text | String | Yes |
| parse_mode | String | No |
| entities | Array of MessageEntity | No |
| link_preview_options | LinkPreviewOptions | No |
| reply_markup | InlineKeyboardMarkup | No |

### editStory

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | Yes |
| story_id | Integer | Yes |
| content | InputStoryContent | Yes |
| caption | String | No |
| parse_mode | String | No |
| caption_entities | Array of MessageEntity | No |
| areas | Array of StoryArea | No |

### editUserStarSubscription

| Parameter | Type | Required |
|-----------|------|----------|
| user_id | Integer | Yes |
| telegram_payment_charge_id | String | Yes |
| is_canceled | Boolean | Yes |


## Answer (inline/callback)

### answerCallbackQuery

| Parameter | Type | Required |
|-----------|------|----------|
| callback_query_id | String | Yes |
| text | String | No |
| show_alert | Boolean | No |
| url | String | No |
| cache_time | Integer | No |

### answerInlineQuery

| Parameter | Type | Required |
|-----------|------|----------|
| inline_query_id | String | Yes |
| results | Array of InlineQueryResult | Yes |
| cache_time | Integer | No |
| is_personal | Boolean | No |
| next_offset | String | No |
| button | InlineQueryResultsButton | No |

### answerPreCheckoutQuery

| Parameter | Type | Required |
|-----------|------|----------|
| pre_checkout_query_id | String | Yes |
| ok | Boolean | Yes |
| error_message | String | No |

### answerShippingQuery

| Parameter | Type | Required |
|-----------|------|----------|
| shipping_query_id | String | Yes |
| ok | Boolean | Yes |
| shipping_options | Array of ShippingOption | No |
| error_message | String | No |

### answerWebAppQuery

| Parameter | Type | Required |
|-----------|------|----------|
| web_app_query_id | String | Yes |
| result | InlineQueryResult | Yes |


## Get info

### getAvailableGifts

_No parameters_

### getBusinessAccountGifts

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | Yes |
| exclude_unsaved | Boolean | No |
| exclude_saved | Boolean | No |
| exclude_unlimited | Boolean | No |
| exclude_limited_upgradable | Boolean | No |
| exclude_limited_non_upgradable | Boolean | No |
| exclude_unique | Boolean | No |
| exclude_from_blockchain | Boolean | No |
| sort_by_price | Boolean | No |
| offset | String | No |
| limit | Integer | No |

### getBusinessAccountStarBalance

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | Yes |

### getBusinessConnection

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | Yes |

### getChat

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |

### getChatAdministrators

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |

### getChatGifts

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| exclude_unsaved | Boolean | No |
| exclude_saved | Boolean | No |
| exclude_unlimited | Boolean | No |
| exclude_limited_upgradable | Boolean | No |
| exclude_limited_non_upgradable | Boolean | No |
| exclude_from_blockchain | Boolean | No |
| exclude_unique | Boolean | No |
| sort_by_price | Boolean | No |
| offset | String | No |
| limit | Integer | No |

### getChatMember

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| user_id | Integer | Yes |

### getChatMemberCount

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |

### getChatMenuButton

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer | No |

### getCustomEmojiStickers

| Parameter | Type | Required |
|-----------|------|----------|
| custom_emoji_ids | Array of String | Yes |

### getFile

| Parameter | Type | Required |
|-----------|------|----------|
| file_id | String | Yes |

### getForumTopicIconStickers

_No parameters_

### getGameHighScores

| Parameter | Type | Required |
|-----------|------|----------|
| user_id | Integer | Yes |
| chat_id | Integer | No |
| message_id | Integer | No |
| inline_message_id | String | No |

### getManagedBotToken

| Parameter | Type | Required |
|-----------|------|----------|
| user_id | Integer | Yes |

### getMyCommands

| Parameter | Type | Required |
|-----------|------|----------|
| scope | BotCommandScope | No |
| language_code | String | No |

### getMyDefaultAdministratorRights

| Parameter | Type | Required |
|-----------|------|----------|
| for_channels | Boolean | No |

### getMyDescription

| Parameter | Type | Required |
|-----------|------|----------|
| language_code | String | No |

### getMyName

| Parameter | Type | Required |
|-----------|------|----------|
| language_code | String | No |

### getMyShortDescription

| Parameter | Type | Required |
|-----------|------|----------|
| language_code | String | No |

### getMyStarBalance

_No parameters_

### getStarTransactions

| Parameter | Type | Required |
|-----------|------|----------|
| offset | Integer | No |
| limit | Integer | No |

### getStickerSet

| Parameter | Type | Required |
|-----------|------|----------|
| name | String | Yes |

### getUserChatBoosts

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| user_id | Integer | Yes |

### getUserGifts

| Parameter | Type | Required |
|-----------|------|----------|
| user_id | Integer | Yes |
| exclude_unlimited | Boolean | No |
| exclude_limited_upgradable | Boolean | No |
| exclude_limited_non_upgradable | Boolean | No |
| exclude_from_blockchain | Boolean | No |
| exclude_unique | Boolean | No |
| sort_by_price | Boolean | No |
| offset | String | No |
| limit | Integer | No |

### getUserProfileAudios

| Parameter | Type | Required |
|-----------|------|----------|
| user_id | Integer | Yes |
| offset | Integer | No |
| limit | Integer | No |

### getUserProfilePhotos

| Parameter | Type | Required |
|-----------|------|----------|
| user_id | Integer | Yes |
| offset | Integer | No |
| limit | Integer | No |


## Set / configure

### setBusinessAccountBio

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | Yes |
| bio | String | No |

### setBusinessAccountGiftSettings

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | Yes |
| show_gift_button | Boolean | Yes |
| accepted_gift_types | AcceptedGiftTypes | Yes |

### setBusinessAccountName

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | Yes |
| first_name | String | Yes |
| last_name | String | No |

### setBusinessAccountProfilePhoto

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | Yes |
| photo | InputProfilePhoto | Yes |
| is_public | Boolean | No |

### setBusinessAccountUsername

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | Yes |
| username | String | No |

### setChatAdministratorCustomTitle

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| user_id | Integer | Yes |
| custom_title | String | Yes |

### setChatDescription

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| description | String | No |

### setChatMemberTag

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| user_id | Integer | Yes |
| tag | String | No |

### setChatMenuButton

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer | No |
| menu_button | MenuButton | No |

### setChatPermissions

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| permissions | ChatPermissions | Yes |
| use_independent_chat_permissions | Boolean | No |

### setChatPhoto

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| photo | InputFile | Yes |

### setChatStickerSet

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| sticker_set_name | String | Yes |

### setChatTitle

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| title | String | Yes |

### setCustomEmojiStickerSetThumbnail

| Parameter | Type | Required |
|-----------|------|----------|
| name | String | Yes |
| custom_emoji_id | String | No |

### setGameScore

| Parameter | Type | Required |
|-----------|------|----------|
| user_id | Integer | Yes |
| score | Integer | Yes |
| force | Boolean | No |
| disable_edit_message | Boolean | No |
| chat_id | Integer | No |
| message_id | Integer | No |
| inline_message_id | String | No |

### setMessageReaction

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| message_id | Integer | Yes |
| reaction | Array of ReactionType | No |
| is_big | Boolean | No |

### setMyCommands

| Parameter | Type | Required |
|-----------|------|----------|
| commands | Array of BotCommand | Yes |
| scope | BotCommandScope | No |
| language_code | String | No |

### setMyDefaultAdministratorRights

| Parameter | Type | Required |
|-----------|------|----------|
| rights | ChatAdministratorRights | No |
| for_channels | Boolean | No |

### setMyDescription

| Parameter | Type | Required |
|-----------|------|----------|
| description | String | No |
| language_code | String | No |

### setMyName

| Parameter | Type | Required |
|-----------|------|----------|
| name | String | No |
| language_code | String | No |

### setMyProfilePhoto

| Parameter | Type | Required |
|-----------|------|----------|
| photo | InputProfilePhoto | Yes |

### setMyShortDescription

| Parameter | Type | Required |
|-----------|------|----------|
| short_description | String | No |
| language_code | String | No |

### setPassportDataErrors

| Parameter | Type | Required |
|-----------|------|----------|
| user_id | Integer | Yes |
| errors | Array of PassportElementError | Yes |

### setStickerEmojiList

| Parameter | Type | Required |
|-----------|------|----------|
| sticker | String | Yes |
| emoji_list | Array of String | Yes |

### setStickerKeywords

| Parameter | Type | Required |
|-----------|------|----------|
| sticker | String | Yes |
| keywords | Array of String | No |

### setStickerMaskPosition

| Parameter | Type | Required |
|-----------|------|----------|
| sticker | String | Yes |
| mask_position | MaskPosition | No |

### setStickerPositionInSet

| Parameter | Type | Required |
|-----------|------|----------|
| sticker | String | Yes |
| position | Integer | Yes |

### setStickerSetThumbnail

| Parameter | Type | Required |
|-----------|------|----------|
| name | String | Yes |
| user_id | Integer | Yes |
| thumbnail | InputFile or String | No |
| format | String | Yes |

### setStickerSetTitle

| Parameter | Type | Required |
|-----------|------|----------|
| name | String | Yes |
| title | String | Yes |

### setUserEmojiStatus

| Parameter | Type | Required |
|-----------|------|----------|
| user_id | Integer | Yes |
| emoji_status_custom_emoji_id | String | No |
| emoji_status_expiration_date | Integer | No |


## Chat admin

### approveChatJoinRequest

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| user_id | Integer | Yes |

### approveSuggestedPost

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer | Yes |
| message_id | Integer | Yes |
| send_date | Integer | No |

### banChatMember

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| user_id | Integer | Yes |
| until_date | Integer | No |
| revoke_messages | Boolean | No |

### banChatSenderChat

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| sender_chat_id | Integer | Yes |

### createChatInviteLink

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| name | String | No |
| expire_date | Integer | No |
| member_limit | Integer | No |
| creates_join_request | Boolean | No |

### createChatSubscriptionInviteLink

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| name | String | No |
| subscription_period | Integer | Yes |
| subscription_price | Integer | Yes |

### declineChatJoinRequest

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| user_id | Integer | Yes |

### declineSuggestedPost

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer | Yes |
| message_id | Integer | Yes |
| comment | String | No |

### exportChatInviteLink

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |

### leaveChat

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |

### promoteChatMember

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| user_id | Integer | Yes |
| is_anonymous | Boolean | No |
| can_manage_chat | Boolean | No |
| can_delete_messages | Boolean | No |
| can_manage_video_chats | Boolean | No |
| can_restrict_members | Boolean | No |
| can_promote_members | Boolean | No |
| can_change_info | Boolean | No |
| can_invite_users | Boolean | No |
| can_post_stories | Boolean | No |
| can_edit_stories | Boolean | No |
| can_delete_stories | Boolean | No |
| can_post_messages | Boolean | No |
| can_edit_messages | Boolean | No |
| can_pin_messages | Boolean | No |
| can_manage_topics | Boolean | No |
| can_manage_direct_messages | Boolean | No |
| can_manage_tags | Boolean | No |

### restrictChatMember

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| user_id | Integer | Yes |
| permissions | ChatPermissions | Yes |
| use_independent_chat_permissions | Boolean | No |
| until_date | Integer | No |

### revokeChatInviteLink

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| invite_link | String | Yes |

### unbanChatMember

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| user_id | Integer | Yes |
| only_if_banned | Boolean | No |

### unbanChatSenderChat

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| sender_chat_id | Integer | Yes |


## Pin / Unpin

### pinChatMessage

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | Yes |
| message_id | Integer | Yes |
| disable_notification | Boolean | No |

### unpinAllChatMessages

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |

### unpinAllForumTopicMessages

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | Yes |

### unpinAllGeneralForumTopicMessages

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |

### unpinChatMessage

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | Yes |
| message_id | Integer | No |


## Forum

### closeForumTopic

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | Yes |

### closeGeneralForumTopic

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |

### createForumTopic

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| name | String | Yes |
| icon_color | Integer | No |
| icon_custom_emoji_id | String | No |

### hideGeneralForumTopic

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |

### reopenForumTopic

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| message_thread_id | Integer | Yes |

### reopenGeneralForumTopic

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |

### unhideGeneralForumTopic

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |


## Stickers

### addStickerToSet

| Parameter | Type | Required |
|-----------|------|----------|
| user_id | Integer | Yes |
| name | String | Yes |
| sticker | InputSticker | Yes |

### createNewStickerSet

| Parameter | Type | Required |
|-----------|------|----------|
| user_id | Integer | Yes |
| name | String | Yes |
| title | String | Yes |
| stickers | Array of InputSticker | Yes |
| sticker_type | String | No |
| needs_repainting | Boolean | No |

### replaceStickerInSet

| Parameter | Type | Required |
|-----------|------|----------|
| user_id | Integer | Yes |
| name | String | Yes |
| old_sticker | String | Yes |
| sticker | InputSticker | Yes |

### uploadStickerFile

| Parameter | Type | Required |
|-----------|------|----------|
| user_id | Integer | Yes |
| sticker | InputFile | Yes |
| sticker_format | String | Yes |


## Payments / Stars

### convertGiftToStars

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | Yes |
| owned_gift_id | String | Yes |

### createInvoiceLink

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| title | String | Yes |
| description | String | Yes |
| payload | String | Yes |
| provider_token | String | No |
| currency | String | Yes |
| prices | Array of LabeledPrice | Yes |
| subscription_period | Integer | No |
| max_tip_amount | Integer | No |
| suggested_tip_amounts | Array of Integer | No |
| provider_data | String | No |
| photo_url | String | No |
| photo_size | Integer | No |
| photo_width | Integer | No |
| photo_height | Integer | No |
| need_name | Boolean | No |
| need_phone_number | Boolean | No |
| need_email | Boolean | No |
| need_shipping_address | Boolean | No |
| send_phone_number_to_provider | Boolean | No |
| send_email_to_provider | Boolean | No |
| is_flexible | Boolean | No |

### refundStarPayment

| Parameter | Type | Required |
|-----------|------|----------|
| user_id | Integer | Yes |
| telegram_payment_charge_id | String | Yes |

### transferBusinessAccountStars

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | Yes |
| star_count | Integer | Yes |

### transferGift

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | Yes |
| owned_gift_id | String | Yes |
| new_owner_chat_id | Integer | Yes |
| star_count | Integer | No |

### upgradeGift

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | Yes |
| owned_gift_id | String | Yes |
| keep_original_details | Boolean | No |
| star_count | Integer | No |


## Business

### readBusinessMessage

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | Yes |
| chat_id | Integer | Yes |
| message_id | Integer | Yes |

### removeBusinessAccountProfilePhoto

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | Yes |
| is_public | Boolean | No |

### replaceManagedBotToken

| Parameter | Type | Required |
|-----------|------|----------|
| user_id | Integer | Yes |


## Stories

### postStory

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | Yes |
| content | InputStoryContent | Yes |
| active_period | Integer | Yes |
| caption | String | No |
| parse_mode | String | No |
| caption_entities | Array of MessageEntity | No |
| areas | Array of StoryArea | No |
| post_to_chat_page | Boolean | No |
| protect_content | Boolean | No |

### repostStory

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | Yes |
| from_chat_id | Integer | Yes |
| from_story_id | Integer | Yes |
| active_period | Integer | Yes |
| post_to_chat_page | Boolean | No |
| protect_content | Boolean | No |


## Gifts

### giftPremiumSubscription

| Parameter | Type | Required |
|-----------|------|----------|
| user_id | Integer | Yes |
| month_count | Integer | Yes |
| star_count | Integer | Yes |
| text | String | No |
| text_parse_mode | String | No |
| text_entities | Array of MessageEntity | No |


## Profile / Commands

### removeMyProfilePhoto

_No parameters_


## Other

### removeChatVerification

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |

### removeUserVerification

| Parameter | Type | Required |
|-----------|------|----------|
| user_id | Integer | Yes |

### savePreparedInlineMessage

| Parameter | Type | Required |
|-----------|------|----------|
| user_id | Integer | Yes |
| result | InlineQueryResult | Yes |
| allow_user_chats | Boolean | No |
| allow_bot_chats | Boolean | No |
| allow_group_chats | Boolean | No |
| allow_channel_chats | Boolean | No |

### savePreparedKeyboardButton

| Parameter | Type | Required |
|-----------|------|----------|
| user_id | Integer | Yes |
| button | KeyboardButton | Yes |

### stopMessageLiveLocation

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | No |
| message_id | Integer | No |
| inline_message_id | String | No |
| reply_markup | InlineKeyboardMarkup | No |

### stopPoll

| Parameter | Type | Required |
|-----------|------|----------|
| business_connection_id | String | No |
| chat_id | Integer or String | Yes |
| message_id | Integer | Yes |
| reply_markup | InlineKeyboardMarkup | No |

### verifyChat

| Parameter | Type | Required |
|-----------|------|----------|
| chat_id | Integer or String | Yes |
| custom_description | String | No |

### verifyUser

| Parameter | Type | Required |
|-----------|------|----------|
| user_id | Integer | Yes |
| custom_description | String | No |

