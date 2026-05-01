# Discord REST API Reference

> Extracted from [discord-api-docs](https://github.com/discord/discord-api-docs)
> Base URL: `https://discord.com/api/v10`
> Auth: `Authorization: Bot <TOKEN>`

> 185 endpoints

## Application Role Connection Metadata

### Get Application Role Connection Metadata Records

```http
GET /applications/{application.id}/role-connections/metadata
```

_No request body parameters_

### Update Application Role Connection Metadata Records

```http
PUT /applications/{application.id}/role-connections/metadata
```

_No request body parameters_

## Application

### Get Current Application

```http
GET /applications/@me
```

_No request body parameters_

### Edit Current Application

```http
PATCH /applications/@me
```

| Parameter | Type | Required |
|-----------|------|----------|
| custom_install_url | string | Yes |
| description | string | Yes |
| role_connections_verification_url | string | Yes |
| install_params | install params object | Yes |
| integration_types_config | dictionary with keys of application integration types | Yes |
| flags  | integer | Yes |
| icon | ?image data | Yes |
| cover_image | ?image data | Yes |
| interactions_endpoint_url  | string | Yes |
| tags | array of strings | Yes |
| event_webhooks_url | string | Yes |
| event_webhooks_status | application event webhook status | Yes |
| event_webhooks_types | array of strings | Yes |

### Get Application Activity Instance

```http
GET /applications/{application.id}/activity-instances/{instance_id}
```

_No request body parameters_

## Audit Log

### Get Guild Audit Log

```http
GET /guilds/{guild.id}/audit-logs
```

_No request body parameters_

## Auto Moderation

### List Auto Moderation Rules for Guild

```http
GET /guilds/{guild.id}/auto-moderation/rules
```

_No request body parameters_

### Get Auto Moderation Rule

```http
GET /guilds/{guild.id}/auto-moderation/rules/{auto_moderation_rule.id}
```

_No request body parameters_

### Create Auto Moderation Rule

```http
POST /guilds/{guild.id}/auto-moderation/rules
```

| Parameter | Type | Required |
|-----------|------|----------|
| name | string | Yes |
| event_type | integer | Yes |
| trigger_type | integer | Yes |
| trigger_metadata?  | object | Yes |
| actions | array of action objects | Yes |
| enabled | boolean | No |
| exempt_roles | array of snowflakes | No |

### Modify Auto Moderation Rule

```http
PATCH /guilds/{guild.id}/auto-moderation/rules/{auto_moderation_rule.id}
```

| Parameter | Type | Required |
|-----------|------|----------|
| name | string | Yes |
| event_type | integer | Yes |
| trigger_metadata?  | object | Yes |
| actions | array of action objects | Yes |
| enabled | boolean | Yes |
| exempt_roles | array of snowflakes | Yes |
| exempt_channels | array of snowflakes | Yes |

### Delete Auto Moderation Rule

```http
DELETE /guilds/{guild.id}/auto-moderation/rules/{auto_moderation_rule.id}
```

_No request body parameters_

## Channel

### Get Channel

```http
GET /channels/{channel.id}
```

_No request body parameters_

### Modify Channel

```http
PATCH /channels/{channel.id}
```

_No request body parameters_

### Set Voice Channel Status

```http
PUT /channels/{channel.id}/voice-status
```

| Parameter | Type | Required |
|-----------|------|----------|
| status | ?string | Yes |

### Delete/Close Channel

```http
DELETE /channels/{channel.id}
```

_No request body parameters_

### Edit Channel Permissions

```http
PUT /channels/{channel.id}/permissions/{overwrite.id}
```

| Parameter | Type | Required |
|-----------|------|----------|
| allow | string? | No |
| deny | string? | No |
| type | integer | Yes |

### Get Channel Invites

```http
GET /channels/{channel.id}/invites
```

_No request body parameters_

### Create Channel Invite

```http
POST /channels/{channel.id}/invites
```

| Parameter | Type | Required |
|-----------|------|----------|
| max_age | integer | Yes |
| max_uses | integer | Yes |
| temporary | boolean | Yes |
| unique | boolean | Yes |
| target_type | integer | Yes |
| target_user_id | snowflake | Yes |
| target_application_id | snowflake | Yes |
| target_users_file? | file | Yes |
| payload_json | string | No |
| role_ids? | array of snowflakes | Yes |

### Delete Channel Permission

```http
DELETE /channels/{channel.id}/permissions/{overwrite.id}
```

_No request body parameters_

### Follow Announcement Channel

```http
POST /channels/{channel.id}/followers
```

| Parameter | Type | Required |
|-----------|------|----------|
| webhook_channel_id | snowflake | Yes |

### Trigger Typing Indicator

```http
POST /channels/{channel.id}/typing
```

_No request body parameters_

### Group DM Add Recipient

```http
PUT /channels/{channel.id}/recipients/{user.id}
```

| Parameter | Type | Required |
|-----------|------|----------|
| access_token | string | Yes |
| nick | string | Yes |

### Group DM Remove Recipient

```http
DELETE /channels/{channel.id}/recipients/{user.id}
```

_No request body parameters_

### Start Thread from Message

```http
POST /channels/{channel.id}/messages/{message.id}/threads
```

| Parameter | Type | Required |
|-----------|------|----------|
| name | string | Yes |
| auto_archive_duration | integer | No |
| rate_limit_per_user | ?integer | No |

### Start Thread without Message

```http
POST /channels/{channel.id}/threads
```

| Parameter | Type | Required |
|-----------|------|----------|
| name | string | Yes |
| auto_archive_duration | integer | No |
| type? | integer | Yes |
| invitable | boolean | No |
| rate_limit_per_user | ?integer | No |

### Start Thread in Forum or Media Channel

```http
POST /channels/{channel.id}/threads
```

| Parameter | Type | Required |
|-----------|------|----------|
| name | string | Yes |
| auto_archive_duration? | integer | Yes |
| rate_limit_per_user | ?integer | No |
| message | a forum thread message params object | Yes |
| applied_tags | array of snowflakes | No |
| files[n]? | file contents | Yes |
| payload_json | string | No |

### Join Thread

```http
PUT /channels/{channel.id}/thread-members/@me
```

_No request body parameters_

### Add Thread Member

```http
PUT /channels/{channel.id}/thread-members/{user.id}
```

_No request body parameters_

### Leave Thread

```http
DELETE /channels/{channel.id}/thread-members/@me
```

_No request body parameters_

### Remove Thread Member

```http
DELETE /channels/{channel.id}/thread-members/{user.id}
```

_No request body parameters_

### Get Thread Member

```http
GET /channels/{channel.id}/thread-members/{user.id}
```

| Parameter | Type | Required |
|-----------|------|----------|
| with_member | boolean | No |

### List Thread Members

```http
GET /channels/{channel.id}/thread-members
```

| Parameter | Type | Required |
|-----------|------|----------|
| with_member | boolean | No |
| after | snowflake | No |
| limit | integer | No |

### List Public Archived Threads

```http
GET /channels/{channel.id}/threads/archived/public
```

| Parameter | Type | Required |
|-----------|------|----------|
| before | ISO8601 timestamp | No |
| limit | integer | No |

### List Private Archived Threads

```http
GET /channels/{channel.id}/threads/archived/private
```

| Parameter | Type | Required |
|-----------|------|----------|
| before | ISO8601 timestamp | No |
| limit | integer | No |

### List Joined Private Archived Threads

```http
GET /channels/{channel.id}/users/@me/threads/archived/private
```

| Parameter | Type | Required |
|-----------|------|----------|
| before | snowflake | No |
| limit | integer | No |

## Emoji

### List Guild Emojis

```http
GET /guilds/{guild.id}/emojis
```

_No request body parameters_

### Get Guild Emoji

```http
GET /guilds/{guild.id}/emojis/{emoji.id}
```

_No request body parameters_

### Create Guild Emoji

```http
POST /guilds/{guild.id}/emojis
```

| Parameter | Type | Required |
|-----------|------|----------|
| name | string | Yes |
| image | image data | Yes |
| roles | array of snowflakes | Yes |

### Modify Guild Emoji

```http
PATCH /guilds/{guild.id}/emojis/{emoji.id}
```

| Parameter | Type | Required |
|-----------|------|----------|
| name | string | Yes |
| roles | ?array of snowflakes | Yes |

### Delete Guild Emoji

```http
DELETE /guilds/{guild.id}/emojis/{emoji.id}
```

_No request body parameters_

### List Application Emojis

```http
GET /applications/{application.id}/emojis
```

_No request body parameters_

### Get Application Emoji

```http
GET /applications/{application.id}/emojis/{emoji.id}
```

_No request body parameters_

### Create Application Emoji

```http
POST /applications/{application.id}/emojis
```

| Parameter | Type | Required |
|-----------|------|----------|
| name | string | Yes |
| image | image data | Yes |

### Modify Application Emoji

```http
PATCH /applications/{application.id}/emojis/{emoji.id}
```

| Parameter | Type | Required |
|-----------|------|----------|
| name | string | Yes |

### Delete Application Emoji

```http
DELETE /applications/{application.id}/emojis/{emoji.id}
```

_No request body parameters_

## Entitlement

### List Entitlements

```http
GET /applications/{application.id}/entitlements
```

| Parameter | Type | Required |
|-----------|------|----------|
| param | type | Yes |
| user_id | snowflake | No |
| sku_ids | comma-delimited set of snowflakes | No |
| before | snowflake | No |
| after | snowflake | No |
| limit | integer | No |
| guild_id | snowflake | No |
| exclude_ended | boolean | No |
| exclude_deleted | boolean | No |

### Get Entitlement

```http
GET /applications/{application.id}/entitlements/{entitlement.id}
```

_No request body parameters_

### Consume an Entitlement

```http
POST /applications/{application.id}/entitlements/{entitlement.id}/consume
```

_No request body parameters_

### Create Test Entitlement

```http
POST /applications/{application.id}/entitlements
```

| Parameter | Type | Required |
|-----------|------|----------|
| param | type | Yes |
| sku_id | string | Yes |
| owner_id | string | Yes |
| owner_type | integer | Yes |

### Delete Test Entitlement

```http
DELETE /applications/{application.id}/entitlements/{entitlement.id}
```

_No request body parameters_

## Guild Scheduled Event

### List Scheduled Events for Guild

```http
GET /guilds/{guild.id}/scheduled-events
```

| Parameter | Type | Required |
|-----------|------|----------|
| with_user_count | boolean | No |

### Create Guild Scheduled Event

```http
POST /guilds/{guild.id}/scheduled-events
```

| Parameter | Type | Required |
|-----------|------|----------|
| channel_id?  | snowflake * | Yes |
| entity_metadata?  | entity metadata | Yes |
| name | string | Yes |
| privacy_level | privacy level | Yes |
| scheduled_start_time | ISO8601 timestamp | Yes |
| scheduled_end_time?  | ISO8601 timestamp | Yes |
| description | string | No |
| entity_type | entity type | Yes |
| image | image data | No |
| recurrence_rule | recurrence rule | No |

### Get Guild Scheduled Event

```http
GET /guilds/{guild.id}/scheduled-events/{guild_scheduled_event.id}
```

| Parameter | Type | Required |
|-----------|------|----------|
| with_user_count | boolean | No |

### Modify Guild Scheduled Event

```http
PATCH /guilds/{guild.id}/scheduled-events/{guild_scheduled_event.id}
```

| Parameter | Type | Required |
|-----------|------|----------|
| channel_id?  | ?snowflake | Yes |
| entity_metadata | ?entity metadata | No |
| name | string | No |
| privacy_level | privacy level | No |
| scheduled_start_time | ISO8601 timestamp | No |
| scheduled_end_time?  | ISO8601 timestamp | Yes |
| description | ?string | No |
| entity_type?  | event entity type | Yes |
| status | event status | No |
| image | image data | No |
| recurrence_rule | ?recurrence rule | No |

### Delete Guild Scheduled Event

```http
DELETE /guilds/{guild.id}/scheduled-events/{guild_scheduled_event.id}
```

_No request body parameters_

### Get Guild Scheduled Event Users

```http
GET /guilds/{guild.id}/scheduled-events/{guild_scheduled_event.id}/users
```

| Parameter | Type | Required |
|-----------|------|----------|
| limit | number | No |
| with_member | boolean | No |
| before?  | snowflake | Yes |
| after?  | snowflake | Yes |

## Guild Template

### Get Guild Template

```http
GET /guilds/templates/{template.code}
```

_No request body parameters_

### Get Guild Templates

```http
GET /guilds/{guild.id}/templates
```

_No request body parameters_

### Create Guild Template

```http
POST /guilds/{guild.id}/templates
```

| Parameter | Type | Required |
|-----------|------|----------|
| name | string | Yes |
| description | ?string | No |

### Sync Guild Template

```http
PUT /guilds/{guild.id}/templates/{template.code}
```

_No request body parameters_

### Modify Guild Template

```http
PATCH /guilds/{guild.id}/templates/{template.code}
```

| Parameter | Type | Required |
|-----------|------|----------|
| name | string | No |
| description | ?string | No |

### Delete Guild Template

```http
DELETE /guilds/{guild.id}/templates/{template.code}
```

_No request body parameters_

## Guild

### Get Guild

```http
GET /guilds/{guild.id}
```

| Parameter | Type | Required |
|-----------|------|----------|
| with_counts | boolean | No |

### Get Guild Preview

```http
GET /guilds/{guild.id}/preview
```

_No request body parameters_

### Modify Guild

```http
PATCH /guilds/{guild.id}
```

| Parameter | Type | Required |
|-----------|------|----------|
| name | string | Yes |
| region | ?string | Yes |
| verification_level | ?integer | Yes |
| default_message_notifications | ?integer | Yes |
| explicit_content_filter | ?integer | Yes |
| afk_channel_id | ?snowflake | Yes |
| afk_timeout | integer | Yes |
| icon | ?image data | Yes |
| splash | ?image data | Yes |
| discovery_splash | ?image data | Yes |
| banner | ?image data | Yes |
| system_channel_id | ?snowflake | Yes |
| system_channel_flags | integer | Yes |
| rules_channel_id | ?snowflake | Yes |
| public_updates_channel_id | ?snowflake | Yes |
| preferred_locale | ?string | Yes |
| features | array of guild feature strings | Yes |
| description | ?string | Yes |
| premium_progress_bar_enabled | boolean | Yes |
| safety_alerts_channel_id | ?snowflake | Yes |

### Get Guild Channels

```http
GET /guilds/{guild.id}/channels
```

_No request body parameters_

### Create Guild Channel

```http
POST /guilds/{guild.id}/channels
```

| Parameter | Type | Required |
|-----------|------|----------|
| name | string | Yes |
| type | integer | Yes |
| topic | string | Yes |
| bitrate | integer | Yes |
| user_limit | integer | Yes |
| rate_limit_per_user | integer | Yes |
| position | integer | Yes |
| permission_overwrites | array of partial overwrite objects | Yes |
| parent_id | snowflake | Yes |
| nsfw | boolean | Yes |
| rtc_region | string | Yes |
| video_quality_mode | integer | Yes |
| default_auto_archive_duration | integer | Yes |
| default_reaction_emoji | default reaction object | Yes |
| available_tags | array of tag objects | Yes |
| default_sort_order | integer | Yes |
| default_forum_layout | integer | Yes |
| default_thread_rate_limit_per_user | integer | Yes |

### Modify Guild Channel Positions

```http
PATCH /guilds/{guild.id}/channels
```

| Parameter | Type | Required |
|-----------|------|----------|
| id | snowflake | Yes |
| position | ?integer | No |
| lock_permissions | ?boolean | No |
| parent_id | ?snowflake | No |

### List Active Guild Threads

```http
GET /guilds/{guild.id}/threads/active
```

_No request body parameters_

### Get Guild Member

```http
GET /guilds/{guild.id}/members/{user.id}
```

_No request body parameters_

### List Guild Members

```http
GET /guilds/{guild.id}/members
```

| Parameter | Type | Required |
|-----------|------|----------|
| limit | integer | Yes |
| after | snowflake | Yes |

### Search Guild Members

```http
GET /guilds/{guild.id}/members/search
```

| Parameter | Type | Required |
|-----------|------|----------|
| query | string | Yes |
| limit | integer | Yes |

### Add Guild Member

```http
PUT /guilds/{guild.id}/members/{user.id}
```

| Parameter | Type | Required |
|-----------|------|----------|
| access_token | string | Yes |
| nick | string | Yes |
| roles | array of snowflakes | Yes |
| mute | boolean | Yes |
| deaf | boolean | Yes |

### Modify Guild Member

```http
PATCH /guilds/{guild.id}/members/{user.id}
```

| Parameter | Type | Required |
|-----------|------|----------|
| nick | string | Yes |
| roles | array of snowflakes | Yes |
| mute | boolean | Yes |
| deaf | boolean | Yes |
| channel_id | snowflake | Yes |
| communication_disabled_until | ISO8601 timestamp | Yes |
| flags | integer | Yes |

### Modify Current Member

```http
PATCH /guilds/{guild.id}/members/@me
```

| Parameter | Type | Required |
|-----------|------|----------|
| nick | ?string | No |
| banner | ?string | No |
| avatar | ?string | No |
| bio | ?string | No |

### Modify Current User Nick

```http
PATCH /guilds/{guild.id}/members/@me/nick
```

| Parameter | Type | Required |
|-----------|------|----------|
| nick | ?string | No |

### Add Guild Member Role

```http
PUT /guilds/{guild.id}/members/{user.id}/roles/{role.id}
```

_No request body parameters_

### Remove Guild Member Role

```http
DELETE /guilds/{guild.id}/members/{user.id}/roles/{role.id}
```

_No request body parameters_

### Remove Guild Member

```http
DELETE /guilds/{guild.id}/members/{user.id}
```

_No request body parameters_

### Get Guild Bans

```http
GET /guilds/{guild.id}/bans
```

| Parameter | Type | Required |
|-----------|------|----------|
| limit | number | No |
| before?  | snowflake | Yes |
| after?  | snowflake | Yes |

### Get Guild Ban

```http
GET /guilds/{guild.id}/bans/{user.id}
```

_No request body parameters_

### Create Guild Ban

```http
PUT /guilds/{guild.id}/bans/{user.id}
```

| Parameter | Type | Required |
|-----------|------|----------|
| delete_message_days | integer | No |
| delete_message_seconds | integer | No |

### Remove Guild Ban

```http
DELETE /guilds/{guild.id}/bans/{user.id}
```

_No request body parameters_

### Bulk Guild Ban

```http
POST /guilds/{guild.id}/bulk-ban
```

| Parameter | Type | Required |
|-----------|------|----------|
| user_ids | array of snowflakes | Yes |
| delete_message_seconds | integer | No |

### Get Guild Roles

```http
GET /guilds/{guild.id}/roles
```

_No request body parameters_

### Get Guild Role

```http
GET /guilds/{guild.id}/roles/{role.id}
```

_No request body parameters_

### Get Guild Role Member Counts

```http
GET /guilds/{guild.id}/roles/member-counts
```

_No request body parameters_

### Create Guild Role

```http
POST /guilds/{guild.id}/roles
```

| Parameter | Type | Required |
|-----------|------|----------|
| name | string | Yes |
| permissions | string | Yes |
| color | integer | Yes |
| colors | role colors object | Yes |
| hoist | boolean | Yes |
| icon | ?image data | Yes |
| unicode_emoji | ?string | Yes |
| mentionable | boolean | Yes |

### Modify Guild Role Positions

```http
PATCH /guilds/{guild.id}/roles
```

| Parameter | Type | Required |
|-----------|------|----------|
| id | snowflake | Yes |
| position | ?integer | No |

### Modify Guild Role

```http
PATCH /guilds/{guild.id}/roles/{role.id}
```

| Parameter | Type | Required |
|-----------|------|----------|
| name | string | Yes |
| permissions | string | Yes |
| color | integer | Yes |
| colors | role colors object | Yes |
| hoist | boolean | Yes |
| icon | image data | Yes |
| unicode_emoji | string | Yes |
| mentionable | boolean | Yes |

### Delete Guild Role

```http
DELETE /guilds/{guild.id}/roles/{role.id}
```

_No request body parameters_

### Get Guild Prune Count

```http
GET /guilds/{guild.id}/prune
```

| Parameter | Type | Required |
|-----------|------|----------|
| days | integer | Yes |
| include_roles | string; comma-delimited array of snowflakes | Yes |

### Begin Guild Prune

```http
POST /guilds/{guild.id}/prune
```

| Parameter | Type | Required |
|-----------|------|----------|
| days | integer | Yes |
| compute_prune_count | boolean | Yes |
| include_roles | array of snowflakes | Yes |
| reason | string | No |

### Get Guild Voice Regions

```http
GET /guilds/{guild.id}/regions
```

_No request body parameters_

### Get Guild Invites

```http
GET /guilds/{guild.id}/invites
```

_No request body parameters_

### Get Guild Integrations

```http
GET /guilds/{guild.id}/integrations
```

_No request body parameters_

### Delete Guild Integration

```http
DELETE /guilds/{guild.id}/integrations/{integration.id}
```

_No request body parameters_

### Get Guild Widget Settings

```http
GET /guilds/{guild.id}/widget
```

_No request body parameters_

### Modify Guild Widget

```http
PATCH /guilds/{guild.id}/widget
```

_No request body parameters_

### Get Guild Widget

```http
GET /guilds/{guild.id}/widget.json
```

_No request body parameters_

### Get Guild Vanity URL

```http
GET /guilds/{guild.id}/vanity-url
```

_No request body parameters_

### Get Guild Widget Image

```http
GET /guilds/{guild.id}/widget.png
```

| Parameter | Type | Required |
|-----------|------|----------|
| style | string | Yes |

### Get Guild Welcome Screen

```http
GET /guilds/{guild.id}/welcome-screen
```

_No request body parameters_

### Modify Guild Welcome Screen

```http
PATCH /guilds/{guild.id}/welcome-screen
```

| Parameter | Type | Required |
|-----------|------|----------|
| enabled | boolean | Yes |
| welcome_channels | array of welcome screen channel objects | Yes |
| description | string | Yes |

### Get Guild Onboarding

```http
GET /guilds/{guild.id}/onboarding
```

_No request body parameters_

### Modify Guild Onboarding

```http
PUT /guilds/{guild.id}/onboarding
```

| Parameter | Type | Required |
|-----------|------|----------|
| prompts | array of onboarding prompt objects | Yes |
| default_channel_ids | array of snowflakes | Yes |
| enabled | boolean | Yes |
| mode | onboarding mode | Yes |

### Modify Guild Incident Actions

```http
PUT /guilds/{guild.id}/incident-actions
```

_No request body parameters_

## Invite

### Get Invite

```http
GET /invites/{invite.code}
```

| Parameter | Type | Required |
|-----------|------|----------|
| with_counts | boolean | No |
| guild_scheduled_event_id | snowflake | No |

### Delete Invite

```http
DELETE /invites/{invite.code}
```

_No request body parameters_

### Get Target Users

```http
GET /invites/{invite.code}/target-users
```

_No request body parameters_

### Update Target Users

```http
PUT /invites/{invite.code}/target-users
```

| Parameter | Type | Required |
|-----------|------|----------|
| target_users_file | file | Yes |

### Get Target Users Job Status

```http
GET /invites/{invite.code}/target-users/job-status
```

_No request body parameters_

## Message

### Get Channel Messages

```http
GET /channels/{channel.id}/messages
```

| Parameter | Type | Required |
|-----------|------|----------|
| around | snowflake | No |
| before | snowflake | No |
| after | snowflake | No |
| limit | integer | No |

### Search Guild Messages

```http
GET /guilds/{guild.id}/messages/search
```

| Parameter | Type | Required |
|-----------|------|----------|
| limit | integer | No |
| offset | integer | No |
| max_id | snowflake | No |
| min_id | snowflake | No |
| slop | integer | No |
| content | string | No |
| channel_id | array of snowflakes | No |
| author_type | array of strings | No |
| author_id | array of snowflakes | No |
| mentions | array of snowflakes | No |
| mentions_role_id | array of snowflakes | No |
| mention_everyone | boolean | No |
| replied_to_user_id | array of snowflakes | No |
| replied_to_message_id | array of snowflakes | No |
| pinned | boolean | No |
| has | array of strings | No |
| embed_type | array of strings | No |
| embed_provider | array of strings | No |
| link_hostname | array of strings | No |
| attachment_filename | array of strings | No |
| attachment_extension | array of strings | No |
| sort_by? [1] | string | Yes |
| sort_order? [1] | string | Yes |
| include_nsfw | boolean | No |

### Get Channel Message

```http
GET /channels/{channel.id}/messages/{message.id}
```

_No request body parameters_

### Create Message

```http
POST /channels/{channel.id}/messages
```

| Parameter | Type | Required |
|-----------|------|----------|
| content? | string | Yes |
| nonce | integer or string | No |
| tts | boolean | No |
| embeds? | array of embed objects | Yes |
| allowed_mentions | allowed mention object | No |
| message_reference? | message reference | Yes |
| components? | array of message component objects | Yes |
| sticker_ids? | array of snowflakes | Yes |
| files[n]? | file contents | Yes |
| payload_json | string | No |
| attachments | array of partial attachment objects | No |
| flags? | integer | Yes |
| enforce_nonce | boolean | No |
| poll | poll request object | No |
| shared_client_theme | shared client theme object | No |

### Crosspost Message

```http
POST /channels/{channel.id}/messages/{message.id}/crosspost
```

_No request body parameters_

### Create Reaction

```http
PUT /channels/{channel.id}/messages/{message.id}/reactions/{emoji.id}/@me
```

_No request body parameters_

### Delete Own Reaction

```http
DELETE /channels/{channel.id}/messages/{message.id}/reactions/{emoji.id}/@me
```

_No request body parameters_

### Delete User Reaction

```http
DELETE /channels/{channel.id}/messages/{message.id}/reactions/{emoji.id}/{user.id}
```

_No request body parameters_

### Get Reactions

```http
GET /channels/{channel.id}/messages/{message.id}/reactions/{emoji.id}
```

| Parameter | Type | Required |
|-----------|------|----------|
| type | integer | No |
| after | snowflake | No |
| limit | integer | No |

### Delete All Reactions

```http
DELETE /channels/{channel.id}/messages/{message.id}/reactions
```

_No request body parameters_

### Delete All Reactions for Emoji

```http
DELETE /channels/{channel.id}/messages/{message.id}/reactions/{emoji.id}
```

_No request body parameters_

### Edit Message

```http
PATCH /channels/{channel.id}/messages/{message.id}
```

| Parameter | Type | Required |
|-----------|------|----------|
| content | string | Yes |
| embeds | array of embed objects | Yes |
| flags | integer | Yes |
| allowed_mentions | allowed mention object | Yes |
| components | array of message component | Yes |
| files[n] | file contents | Yes |
| payload_json | string | Yes |
| attachments | array of attachment objects | Yes |

### Delete Message

```http
DELETE /channels/{channel.id}/messages/{message.id}
```

_No request body parameters_

### Bulk Delete Messages

```http
POST /channels/{channel.id}/messages/bulk-delete
```

| Parameter | Type | Required |
|-----------|------|----------|
| messages | array of snowflakes | Yes |

### Get Channel Pins

```http
GET /channels/{channel.id}/messages/pins
```

| Parameter | Type | Required |
|-----------|------|----------|
| before | ISO8601 timestamp | No |
| limit | integer | No |

### Pin Message

```http
PUT /channels/{channel.id}/messages/pins/{message.id}
```

_No request body parameters_

### Unpin Message

```http
DELETE /channels/{channel.id}/messages/pins/{message.id}
```

_No request body parameters_

### Get Pinned Messages (deprecated)

```http
GET /channels/{channel.id}/pins
```

_No request body parameters_

### Pin Message (deprecated)

```http
PUT /channels/{channel.id}/pins/{message.id}
```

_No request body parameters_

### Unpin Message (deprecated)

```http
DELETE /channels/{channel.id}/pins/{message.id}
```

_No request body parameters_

## Poll

### Get Answer Voters

```http
GET /channels/{channel.id}/polls/{message.id}/answers/{answer_id}
```

| Parameter | Type | Required |
|-----------|------|----------|
| after | snowflake | No |
| limit | integer | No |

### End Poll

```http
POST /channels/{channel.id}/polls/{message.id}/expire
```

_No request body parameters_

## Sku

### List SKUs

```http
GET /applications/{application.id}/skus
```

_No request body parameters_

## Soundboard

### Send Soundboard Sound

```http
POST /channels/{channel.id}/send-soundboard-sound
```

| Parameter | Type | Required |
|-----------|------|----------|
| sound_id | snowflake | Yes |
| source_guild_id | snowflake | No |

### List Default Soundboard Sounds

```http
GET /soundboard-default-sounds
```

_No request body parameters_

### List Guild Soundboard Sounds

```http
GET /guilds/{guild.id}/soundboard-sounds
```

_No request body parameters_

### Get Guild Soundboard Sound

```http
GET /guilds/{guild.id}/soundboard-sounds/{sound.id}
```

_No request body parameters_

### Create Guild Soundboard Sound

```http
POST /guilds/{guild.id}/soundboard-sounds
```

| Parameter | Type | Required |
|-----------|------|----------|
| name | string | Yes |
| sound | data uri | Yes |
| volume | ?double | No |
| emoji_id | ?snowflake | No |
| emoji_name | ?string | No |

### Modify Guild Soundboard Sound

```http
PATCH /guilds/{guild.id}/soundboard-sounds/{sound.id}
```

| Parameter | Type | Required |
|-----------|------|----------|
| name | string | Yes |
| volume | ?double | Yes |
| emoji_id | ?snowflake | Yes |
| emoji_name | ?string | Yes |

### Delete Guild Soundboard Sound

```http
DELETE /guilds/{guild.id}/soundboard-sounds/{sound.id}
```

_No request body parameters_

## Stage Instance

### Create Stage Instance

```http
POST /stage-instances
```

| Parameter | Type | Required |
|-----------|------|----------|
| channel_id | snowflake | Yes |
| topic | string | Yes |
| privacy_level | integer | No |
| send_start_notification?  | boolean | Yes |
| guild_scheduled_event_id | snowflake | No |

### Get Stage Instance

```http
GET /stage-instances/{channel.id}
```

_No request body parameters_

### Modify Stage Instance

```http
PATCH /stage-instances/{channel.id}
```

| Parameter | Type | Required |
|-----------|------|----------|
| privacy_level | integer | No |

### Delete Stage Instance

```http
DELETE /stage-instances/{channel.id}
```

_No request body parameters_

## Sticker

### Get Sticker

```http
GET /stickers/{sticker.id}
```

_No request body parameters_

### List Sticker Packs

```http
GET /sticker-packs
```

_No request body parameters_

### Get Sticker Pack

```http
GET /sticker-packs/{pack.id}
```

_No request body parameters_

### List Guild Stickers

```http
GET /guilds/{guild.id}/stickers
```

_No request body parameters_

### Get Guild Sticker

```http
GET /guilds/{guild.id}/stickers/{sticker.id}
```

_No request body parameters_

### Create Guild Sticker

```http
POST /guilds/{guild.id}/stickers
```

| Parameter | Type | Required |
|-----------|------|----------|
| name | string | Yes |
| description | string | Yes |
| tags | string | Yes |
| file | file contents | Yes |

### Modify Guild Sticker

```http
PATCH /guilds/{guild.id}/stickers/{sticker.id}
```

| Parameter | Type | Required |
|-----------|------|----------|
| name | string | Yes |
| description | ?string | Yes |
| tags | string | Yes |

### Delete Guild Sticker

```http
DELETE /guilds/{guild.id}/stickers/{sticker.id}
```

_No request body parameters_

## Subscription

### List SKU Subscriptions

```http
GET /skus/{sku.id}/subscriptions
```

_No request body parameters_

### Get SKU Subscription

```http
GET /skus/{sku.id}/subscriptions/{subscription.id}
```

_No request body parameters_

## User

### Get Current User

```http
GET /users/@me
```

_No request body parameters_

### Get User

```http
GET /users/{user.id}
```

_No request body parameters_

### Modify Current User

```http
PATCH /users/@me
```

| Parameter | Type | Required |
|-----------|------|----------|
| username | string | Yes |
| avatar | ?image data | Yes |
| banner | ?image data | Yes |

### Get Current User Guilds

```http
GET /users/@me/guilds
```

| Parameter | Type | Required |
|-----------|------|----------|
| before | snowflake | Yes |
| after | snowflake | Yes |
| limit | integer | Yes |
| with_counts | boolean | Yes |

### Get Current User Guild Member

```http
GET /users/@me/guilds/{guild.id}/member
```

_No request body parameters_

### Leave Guild

```http
DELETE /users/@me/guilds/{guild.id}
```

_No request body parameters_

### Create DM

```http
POST /users/@me/channels
```

| Parameter | Type | Required |
|-----------|------|----------|
| recipient_id | snowflake | Yes |

### Create Group DM

```http
POST /users/@me/channels
```

| Parameter | Type | Required |
|-----------|------|----------|
| access_tokens | array of strings | Yes |
| nicks | dict | Yes |

### Get Current User Connections

```http
GET /users/@me/connections
```

_No request body parameters_

## Voice

### List Voice Regions

```http
GET /voice/regions
```

_No request body parameters_

### Get Current User Voice State

```http
GET /guilds/{guild.id}/voice-states/@me
```

_No request body parameters_

### Get User Voice State

```http
GET /guilds/{guild.id}/voice-states/{user.id}
```

_No request body parameters_

### Modify Current User Voice State

```http
PATCH /guilds/{guild.id}/voice-states/@me
```

| Parameter | Type | Required |
|-----------|------|----------|
| channel_id | snowflake | No |
| suppress | boolean | No |
| request_to_speak_timestamp | ?ISO8601 timestamp | No |

### Modify User Voice State

```http
PATCH /guilds/{guild.id}/voice-states/{user.id}
```

| Parameter | Type | Required |
|-----------|------|----------|
| channel_id | snowflake | No |
| suppress | boolean | No |

## Webhook

### Create Webhook

```http
POST /channels/{channel.id}/webhooks
```

| Parameter | Type | Required |
|-----------|------|----------|
| name | string | Yes |
| avatar | ?image data | No |

### Get Channel Webhooks

```http
GET /channels/{channel.id}/webhooks
```

_No request body parameters_

### Get Guild Webhooks

```http
GET /guilds/{guild.id}/webhooks
```

_No request body parameters_

### Get Webhook

```http
GET /webhooks/{webhook.id}
```

_No request body parameters_

### Get Webhook with Token

```http
GET /webhooks/{webhook.id}/{webhook.token}
```

_No request body parameters_

### Modify Webhook

```http
PATCH /webhooks/{webhook.id}
```

| Parameter | Type | Required |
|-----------|------|----------|
| name | string | Yes |
| avatar | ?image data | Yes |
| channel_id | snowflake | Yes |

### Modify Webhook with Token

```http
PATCH /webhooks/{webhook.id}/{webhook.token}
```

_No request body parameters_

### Delete Webhook

```http
DELETE /webhooks/{webhook.id}
```

_No request body parameters_

### Delete Webhook with Token

```http
DELETE /webhooks/{webhook.id}/{webhook.token}
```

_No request body parameters_

### Execute Webhook

```http
POST /webhooks/{webhook.id}/{webhook.token}
```

| Parameter | Type | Required |
|-----------|------|----------|
| wait | boolean | Yes |
| thread_id | snowflake | Yes |
| with_components | boolean | Yes |
| content | string | Yes |
| username | string | Yes |
| avatar_url | string | Yes |
| tts | boolean | Yes |
| embeds | array of up to 10 embed objects | Yes |
| allowed_mentions | allowed mention object | Yes |
| components  | array of message component | Yes |
| files[n]  | file contents | Yes |
| payload_json  | string | Yes |
| attachments  | array of partial attachment objects | Yes |
| flags  | integer | Yes |
| thread_name | string | Yes |
| applied_tags | array of snowflakes | Yes |
| poll | poll request object | Yes |

### Execute Slack-Compatible Webhook

```http
POST /webhooks/{webhook.id}/{webhook.token}/slack
```

| Parameter | Type | Required |
|-----------|------|----------|
| thread_id | snowflake | Yes |
| wait | boolean | Yes |

### Execute GitHub-Compatible Webhook

```http
POST /webhooks/{webhook.id}/{webhook.token}/github
```

| Parameter | Type | Required |
|-----------|------|----------|
| thread_id | snowflake | Yes |
| wait | boolean | Yes |

### Get Webhook Message

```http
GET /webhooks/{webhook.id}/{webhook.token}/messages/{message.id}
```

| Parameter | Type | Required |
|-----------|------|----------|
| thread_id | snowflake | Yes |

### Edit Webhook Message

```http
PATCH /webhooks/{webhook.id}/{webhook.token}/messages/{message.id}
```

| Parameter | Type | Required |
|-----------|------|----------|
| thread_id | snowflake | Yes |
| with_components | boolean | Yes |
| content | string | Yes |
| embeds | array of up to 10 embed objects | Yes |
| flags  | integer | Yes |
| allowed_mentions | allowed mention object | Yes |
| components  | array of message component | Yes |
| files[n]  | file contents | Yes |
| payload_json  | string | Yes |
| attachments  | array of partial attachment objects | Yes |
| poll  | poll request object | Yes |

### Delete Webhook Message

```http
DELETE /webhooks/{webhook.id}/{webhook.token}/messages/{message.id}
```

| Parameter | Type | Required |
|-----------|------|----------|
| thread_id | snowflake | Yes |
