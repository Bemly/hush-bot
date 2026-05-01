# Discord REST API Reference

> Extracted from [discord-api-docs](https://github.com/discord/discord-api-docs)
> Base URL: `https://discord.com/api/v10`
> Auth: `Authorization: Bot <TOKEN>`

> 198 endpoints

## Application Role Connection Metadata

### Get Application Role Connection Metadata Records

```http
GET /applications/{application.id}/role-connections/metadata
```

### Update Application Role Connection Metadata Records

```http
PUT /applications/{application.id}/role-connections/metadata
```

## Application

### Get Current Application

```http
GET /applications/@me
```

### Edit Current Application

```http
PATCH /applications/@me
```

### Get Application Activity Instance

```http
GET /applications/{application.id}/activity-instances/{instance_id}
```

## Audit Log

### Get Guild Audit Log

```http
GET /guilds/{guild.id}/audit-logs
```

## Auto Moderation

### List Auto Moderation Rules for Guild

```http
GET /guilds/{guild.id}/auto-moderation/rules
```

### Get Auto Moderation Rule

```http
GET /guilds/{guild.id}/auto-moderation/rules/{auto_moderation_rule.id}
```

### Create Auto Moderation Rule

```http
POST /guilds/{guild.id}/auto-moderation/rules
```

### Modify Auto Moderation Rule

```http
PATCH /guilds/{guild.id}/auto-moderation/rules/{auto_moderation_rule.id}
```

### Delete Auto Moderation Rule

```http
DELETE /guilds/{guild.id}/auto-moderation/rules/{auto_moderation_rule.id}
```

## Channel

### Get Channel

```http
GET /channels/{channel.id}
```

### Modify Channel

```http
PATCH /channels/{channel.id}
```

### Set Voice Channel Status

```http
PUT /channels/{channel.id}/voice-status
```

### Delete/Close Channel

```http
DELETE /channels/{channel.id}
```

### Edit Channel Permissions

```http
PUT /channels/{channel.id}/permissions/{overwrite.id}
```

### Get Channel Invites

```http
GET /channels/{channel.id}/invites
```

### Create Channel Invite

```http
POST /channels/{channel.id}/invites
```

### Delete Channel Permission

```http
DELETE /channels/{channel.id}/permissions/{overwrite.id}
```

### Follow Announcement Channel

```http
POST /channels/{channel.id}/followers
```

### Trigger Typing Indicator

```http
POST /channels/{channel.id}/typing
```

### Group DM Add Recipient

```http
PUT /channels/{channel.id}/recipients/{user.id}
```

### Group DM Remove Recipient

```http
DELETE /channels/{channel.id}/recipients/{user.id}
```

### Start Thread from Message

```http
POST /channels/{channel.id}/messages/{message.id}/threads
```

### Start Thread without Message

```http
POST /channels/{channel.id}/threads
```

### Start Thread in Forum or Media Channel

```http
POST /channels/{channel.id}/threads
```

### Join Thread

```http
PUT /channels/{channel.id}/thread-members/@me
```

### Add Thread Member

```http
PUT /channels/{channel.id}/thread-members/{user.id}
```

### Leave Thread

```http
DELETE /channels/{channel.id}/thread-members/@me
```

### Remove Thread Member

```http
DELETE /channels/{channel.id}/thread-members/{user.id}
```

### Get Thread Member

```http
GET /channels/{channel.id}/thread-members/{user.id}
```

### List Thread Members

```http
GET /channels/{channel.id}/thread-members
```

### List Public Archived Threads

```http
GET /channels/{channel.id}/threads/archived/public
```

### List Private Archived Threads

```http
GET /channels/{channel.id}/threads/archived/private
```

### List Joined Private Archived Threads

```http
GET /channels/{channel.id}/users/@me/threads/archived/private
```

## Emoji

### List Guild Emojis

```http
GET /guilds/{guild.id}/emojis
```

### Get Guild Emoji

```http
GET /guilds/{guild.id}/emojis/{emoji.id}
```

### Create Guild Emoji

```http
POST /guilds/{guild.id}/emojis
```

### Modify Guild Emoji

```http
PATCH /guilds/{guild.id}/emojis/{emoji.id}
```

### Delete Guild Emoji

```http
DELETE /guilds/{guild.id}/emojis/{emoji.id}
```

### List Application Emojis

```http
GET /applications/{application.id}/emojis
```

### Get Application Emoji

```http
GET /applications/{application.id}/emojis/{emoji.id}
```

### Create Application Emoji

```http
POST /applications/{application.id}/emojis
```

### Modify Application Emoji

```http
PATCH /applications/{application.id}/emojis/{emoji.id}
```

### Delete Application Emoji

```http
DELETE /applications/{application.id}/emojis/{emoji.id}
```

## Entitlement

### List Entitlements

```http
GET /applications/{application.id}/entitlements
```

### Get Entitlement

```http
GET /applications/{application.id}/entitlements/{entitlement.id}
```

### Consume an Entitlement

```http
POST /applications/{application.id}/entitlements/{entitlement.id}/consume
```

### Create Test Entitlement

```http
POST /applications/{application.id}/entitlements
```

### Delete Test Entitlement

```http
DELETE /applications/{application.id}/entitlements/{entitlement.id}
```

## Guild Scheduled Event

### List Scheduled Events for Guild

```http
GET /guilds/{guild.id}/scheduled-events
```

### Create Guild Scheduled Event

```http
POST /guilds/{guild.id}/scheduled-events
```

### Get Guild Scheduled Event

```http
GET /guilds/{guild.id}/scheduled-events/{guild_scheduled_event.id}
```

### Modify Guild Scheduled Event

```http
PATCH /guilds/{guild.id}/scheduled-events/{guild_scheduled_event.id}
```

### Delete Guild Scheduled Event

```http
DELETE /guilds/{guild.id}/scheduled-events/{guild_scheduled_event.id}
```

### Get Guild Scheduled Event Users

```http
GET /guilds/{guild.id}/scheduled-events/{guild_scheduled_event.id}/users
```

## Guild Template

### Get Guild Template

```http
GET /guilds/templates/{template.code}
```

### Get Guild Templates

```http
GET /guilds/{guild.id}/templates
```

### Create Guild Template

```http
POST /guilds/{guild.id}/templates
```

### Sync Guild Template

```http
PUT /guilds/{guild.id}/templates/{template.code}
```

### Modify Guild Template

```http
PATCH /guilds/{guild.id}/templates/{template.code}
```

### Delete Guild Template

```http
DELETE /guilds/{guild.id}/templates/{template.code}
```

## Guild

### Get Guild

```http
GET /guilds/{guild.id}
```

### Get Guild Preview

```http
GET /guilds/{guild.id}/preview
```

### Modify Guild

```http
PATCH /guilds/{guild.id}
```

### Get Guild Channels

```http
GET /guilds/{guild.id}/channels
```

### Create Guild Channel

```http
POST /guilds/{guild.id}/channels
```

### Modify Guild Channel Positions

```http
PATCH /guilds/{guild.id}/channels
```

### List Active Guild Threads

```http
GET /guilds/{guild.id}/threads/active
```

### Get Guild Member

```http
GET /guilds/{guild.id}/members/{user.id}
```

### List Guild Members

```http
GET /guilds/{guild.id}/members
```

### Search Guild Members

```http
GET /guilds/{guild.id}/members/search
```

### Add Guild Member

```http
PUT /guilds/{guild.id}/members/{user.id}
```

### Modify Guild Member

```http
PATCH /guilds/{guild.id}/members/{user.id}
```

### Modify Current Member

```http
PATCH /guilds/{guild.id}/members/@me
```

### Modify Current User Nick

```http
PATCH /guilds/{guild.id}/members/@me/nick
```

### Add Guild Member Role

```http
PUT /guilds/{guild.id}/members/{user.id}/roles/{role.id}
```

### Remove Guild Member Role

```http
DELETE /guilds/{guild.id}/members/{user.id}/roles/{role.id}
```

### Remove Guild Member

```http
DELETE /guilds/{guild.id}/members/{user.id}
```

### Get Guild Bans

```http
GET /guilds/{guild.id}/bans
```

### Get Guild Ban

```http
GET /guilds/{guild.id}/bans/{user.id}
```

### Create Guild Ban

```http
PUT /guilds/{guild.id}/bans/{user.id}
```

### Remove Guild Ban

```http
DELETE /guilds/{guild.id}/bans/{user.id}
```

### Bulk Guild Ban

```http
POST /guilds/{guild.id}/bulk-ban
```

### Get Guild Roles

```http
GET /guilds/{guild.id}/roles
```

### Get Guild Role

```http
GET /guilds/{guild.id}/roles/{role.id}
```

### Get Guild Role Member Counts

```http
GET /guilds/{guild.id}/roles/member-counts
```

### Create Guild Role

```http
POST /guilds/{guild.id}/roles
```

### Modify Guild Role Positions

```http
PATCH /guilds/{guild.id}/roles
```

### Modify Guild Role

```http
PATCH /guilds/{guild.id}/roles/{role.id}
```

### Delete Guild Role

```http
DELETE /guilds/{guild.id}/roles/{role.id}
```

### Get Guild Prune Count

```http
GET /guilds/{guild.id}/prune
```

### Begin Guild Prune

```http
POST /guilds/{guild.id}/prune
```

### Get Guild Voice Regions

```http
GET /guilds/{guild.id}/regions
```

### Get Guild Invites

```http
GET /guilds/{guild.id}/invites
```

### Get Guild Integrations

```http
GET /guilds/{guild.id}/integrations
```

### Delete Guild Integration

```http
DELETE /guilds/{guild.id}/integrations/{integration.id}
```

### Get Guild Widget Settings

```http
GET /guilds/{guild.id}/widget
```

### Modify Guild Widget

```http
PATCH /guilds/{guild.id}/widget
```

### Get Guild Widget

```http
GET /guilds/{guild.id}/widget.json
```

### Get Guild Vanity URL

```http
GET /guilds/{guild.id}/vanity-url
```

### Get Guild Widget Image

```http
GET /guilds/{guild.id}/widget.png
```

### Get Guild Welcome Screen

```http
GET /guilds/{guild.id}/welcome-screen
```

### Modify Guild Welcome Screen

```http
PATCH /guilds/{guild.id}/welcome-screen
```

### Get Guild Onboarding

```http
GET /guilds/{guild.id}/onboarding
```

### Modify Guild Onboarding

```http
PUT /guilds/{guild.id}/onboarding
```

### Modify Guild Incident Actions

```http
PUT /guilds/{guild.id}/incident-actions
```

## Invite

### Get Invite

```http
GET /invites/{invite.code}
```

### Delete Invite

```http
DELETE /invites/{invite.code}
```

### Get Target Users

```http
GET /invites/{invite.code}/target-users
```

### Update Target Users

```http
PUT /invites/{invite.code}/target-users
```

### Get Target Users Job Status

```http
GET /invites/{invite.code}/target-users/job-status
```

## Lobby

### Create Lobby

```http
POST /lobbies
```

### Get Lobby

```http
GET /lobbies/{lobby.id}
```

### Modify Lobby

```http
PATCH /lobbies/{lobby.id}
```

### Delete Lobby

```http
DELETE /lobbies/{lobby.id}
```

### Add a Member to a Lobby

```http
PUT /lobbies/{lobby.id}/members/{user.id}
```

### Bulk Update Lobby Members

```http
POST /lobbies/{lobby.id}/members/bulk
```

### Remove a Member from a Lobby

```http
DELETE /lobbies/{lobby.id}/members/{user.id}
```

### Leave Lobby

```http
DELETE /lobbies/{lobby.id}/members/@me
```

### Link Channel to Lobby

```http
PATCH /lobbies/{lobby.id}/channel-linking
```

### Unlink Channel from Lobby

```http
PATCH /lobbies/{lobby.id}/channel-linking
```

### Update Lobby Message Moderation Metadata

```http
PUT /lobbies/{lobby.id}/messages/{message.id}/moderation-metadata
```

## Message

### Get Channel Messages

```http
GET /channels/{channel.id}/messages
```

### Search Guild Messages

```http
GET /guilds/{guild.id}/messages/search
```

### Get Channel Message

```http
GET /channels/{channel.id}/messages/{message.id}
```

### Create Message

```http
POST /channels/{channel.id}/messages
```

### Crosspost Message

```http
POST /channels/{channel.id}/messages/{message.id}/crosspost
```

### Create Reaction

```http
PUT /channels/{channel.id}/messages/{message.id}/reactions/{emoji.id}/@me
```

### Delete Own Reaction

```http
DELETE /channels/{channel.id}/messages/{message.id}/reactions/{emoji.id}/@me
```

### Delete User Reaction

```http
DELETE /channels/{channel.id}/messages/{message.id}/reactions/{emoji.id}/{user.id}
```

### Get Reactions

```http
GET /channels/{channel.id}/messages/{message.id}/reactions/{emoji.id}
```

### Delete All Reactions

```http
DELETE /channels/{channel.id}/messages/{message.id}/reactions
```

### Delete All Reactions for Emoji

```http
DELETE /channels/{channel.id}/messages/{message.id}/reactions/{emoji.id}
```

### Edit Message

```http
PATCH /channels/{channel.id}/messages/{message.id}
```

### Delete Message

```http
DELETE /channels/{channel.id}/messages/{message.id}
```

### Bulk Delete Messages

```http
POST /channels/{channel.id}/messages/bulk-delete
```

### Get Channel Pins

```http
GET /channels/{channel.id}/messages/pins
```

### Pin Message

```http
PUT /channels/{channel.id}/messages/pins/{message.id}
```

### Unpin Message

```http
DELETE /channels/{channel.id}/messages/pins/{message.id}
```

### Get Pinned Messages (deprecated)

```http
GET /channels/{channel.id}/pins
```

### Pin Message (deprecated)

```http
PUT /channels/{channel.id}/pins/{message.id}
```

### Unpin Message (deprecated)

```http
DELETE /channels/{channel.id}/pins/{message.id}
```

## Poll

### Get Answer Voters

```http
GET /channels/{channel.id}/polls/{message.id}/answers/{answer_id}
```

### End Poll

```http
POST /channels/{channel.id}/polls/{message.id}/expire
```

## Sku

### List SKUs

```http
GET /applications/{application.id}/skus
```

## Soundboard

### Send Soundboard Sound

```http
POST /channels/{channel.id}/send-soundboard-sound
```

### List Default Soundboard Sounds

```http
GET /soundboard-default-sounds
```

### List Guild Soundboard Sounds

```http
GET /guilds/{guild.id}/soundboard-sounds
```

### Get Guild Soundboard Sound

```http
GET /guilds/{guild.id}/soundboard-sounds/{sound.id}
```

### Create Guild Soundboard Sound

```http
POST /guilds/{guild.id}/soundboard-sounds
```

### Modify Guild Soundboard Sound

```http
PATCH /guilds/{guild.id}/soundboard-sounds/{sound.id}
```

### Delete Guild Soundboard Sound

```http
DELETE /guilds/{guild.id}/soundboard-sounds/{sound.id}
```

## Stage Instance

### Create Stage Instance

```http
POST /stage-instances
```

### Get Stage Instance

```http
GET /stage-instances/{channel.id}
```

### Modify Stage Instance

```http
PATCH /stage-instances/{channel.id}
```

### Delete Stage Instance

```http
DELETE /stage-instances/{channel.id}
```

## Sticker

### Get Sticker

```http
GET /stickers/{sticker.id}
```

### List Sticker Packs

```http
GET /sticker-packs
```

### Get Sticker Pack

```http
GET /sticker-packs/{pack.id}
```

### List Guild Stickers

```http
GET /guilds/{guild.id}/stickers
```

### Get Guild Sticker

```http
GET /guilds/{guild.id}/stickers/{sticker.id}
```

### Create Guild Sticker

```http
POST /guilds/{guild.id}/stickers
```

### Modify Guild Sticker

```http
PATCH /guilds/{guild.id}/stickers/{sticker.id}
```

### Delete Guild Sticker

```http
DELETE /guilds/{guild.id}/stickers/{sticker.id}
```

## Subscription

### List SKU Subscriptions

```http
GET /skus/{sku.id}/subscriptions
```

### Get SKU Subscription

```http
GET /skus/{sku.id}/subscriptions/{subscription.id}
```

## User

### Get Current User

```http
GET /users/@me
```

### Get User

```http
GET /users/{user.id}
```

### Modify Current User

```http
PATCH /users/@me
```

### Get Current User Guilds

```http
GET /users/@me/guilds
```

### Get Current User Guild Member

```http
GET /users/@me/guilds/{guild.id}/member
```

### Leave Guild

```http
DELETE /users/@me/guilds/{guild.id}
```

### Create DM

```http
POST /users/@me/channels
```

### Create Group DM

```http
POST /users/@me/channels
```

### Get Current User Connections

```http
GET /users/@me/connections
```

### Get Current User Application Role Connection

```http
GET /users/@me/applications/{application.id}/role-connection
```

### Update Current User Application Role Connection

```http
PUT /users/@me/applications/{application.id}/role-connection
```

## Voice

### List Voice Regions

```http
GET /voice/regions
```

### Get Current User Voice State

```http
GET /guilds/{guild.id}/voice-states/@me
```

### Get User Voice State

```http
GET /guilds/{guild.id}/voice-states/{user.id}
```

### Modify Current User Voice State

```http
PATCH /guilds/{guild.id}/voice-states/@me
```

### Modify User Voice State

```http
PATCH /guilds/{guild.id}/voice-states/{user.id}
```

## Webhook

### Create Webhook

```http
POST /channels/{channel.id}/webhooks
```

### Get Channel Webhooks

```http
GET /channels/{channel.id}/webhooks
```

### Get Guild Webhooks

```http
GET /guilds/{guild.id}/webhooks
```

### Get Webhook

```http
GET /webhooks/{webhook.id}
```

### Get Webhook with Token

```http
GET /webhooks/{webhook.id}/{webhook.token}
```

### Modify Webhook

```http
PATCH /webhooks/{webhook.id}
```

### Modify Webhook with Token

```http
PATCH /webhooks/{webhook.id}/{webhook.token}
```

### Delete Webhook

```http
DELETE /webhooks/{webhook.id}
```

### Delete Webhook with Token

```http
DELETE /webhooks/{webhook.id}/{webhook.token}
```

### Execute Webhook

```http
POST /webhooks/{webhook.id}/{webhook.token}
```

### Execute Slack-Compatible Webhook

```http
POST /webhooks/{webhook.id}/{webhook.token}/slack
```

### Execute GitHub-Compatible Webhook

```http
POST /webhooks/{webhook.id}/{webhook.token}/github
```

### Get Webhook Message

```http
GET /webhooks/{webhook.id}/{webhook.token}/messages/{message.id}
```

### Edit Webhook Message

```http
PATCH /webhooks/{webhook.id}/{webhook.token}/messages/{message.id}
```

### Delete Webhook Message

```http
DELETE /webhooks/{webhook.id}/{webhook.token}/messages/{message.id}
```
