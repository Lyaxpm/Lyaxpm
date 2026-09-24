local Config = {}
 
-- ============================================================
-- WX SAWERIA V2 — NO LICENSE / NO SECRET / NO ACCESS KEY
-- ============================================================
-- Webhook Saweria:
-- POST https://sweria.wheen9296.workers.dev/saweria
--
-- Roblox hanya memakai endpoint publik /api/pull dan /api/ack.
-- Tidak ada GameId key, whitelist produk, heartbeat lisensi, kick,
-- anti-tamper, atau validasi kepemilikan ekster
Config.Connection = {
WorkerBaseUrl = "https://g3n.me-0c9.workers.dev",
PullPath = "/api/pull",
AckPath = "/api/ack",
WebhookPath = "/saweria",
PollInterval = 3,
PullLimit = 10,
UseMessagingService = true,
MessagingTopic = "WX_SAWERIA_GLOBAL_V2",
}
 
Config.TopbarIcon = {
Label = "Donasi",
Image = "rbxassetid://79818603617996",
}
 
Config.GameInfo = {
Title = "Five Second",
Description = "Terimakasih sudah support kamu, love u",
Image = "rbxassetid://80615069806225",
}
 
Config.Saweria = {
Link = "https://saweria.co/FiveSecond",
}
 
Config.Admins = {
Usernames = { "GenAvatarAgin" },
UserIds = { 8388619264 },
}
 
Config.Timing = {
PollInterval = 3,
NotifDisplayTime = 7,
BoardRefreshTime = 60,
}
 
Config.Notif = {
HeaderPrefix = "Donasi Dari ",
UsePrefixAt = true,
NameColor = Color3.fromRGB(255, 170, 0),
HeaderColor = nil,
DefaultMessage = "Terima kasih banyak atas dukungannya!",
DefaultAvatar = "rbxasset://textures/ui/GuiImagePlaceholder.png",
MobileScale = 0.72,
SoundId = "rbxassetid://6809101819",
SoundVolume = 0.9,
}
 
Config.DefaultRecipient = "Five Second"
Config.CurrencyPrefix = "Rp "
Config.CurrencySuffix = ""
 
Config.FakeDonate = {
Enabled = true,
ButtonImage = "rbxassetid://18797417802",
DefaultAmount = 5000,
DefaultText = "Nitip kak, semoga sukses selalu ya!",
EffectDefault = true,
PersistToBoard = false,
}
 
Config.EffectDuration = {
Nuke = 50000,
Hammer = 500000,
BlackHole = 1000000,
}
 
Config.Enabled = {
Nuke = true,
Hammer = true,
BlackHole = true,
}
 
Config.LevelEffect = {
Enabled = true,
FolderName = "Level Effect",
Offset = CFrame.new(0, 0, 0),
Levels = {
{ Name = "Level1", MinAmount = 1, Duration = 6, Enabled = true },
{ Name = "Level2", MinAmount = 30000, Duration = 8, Enabled = true },
{ Name = "Level3", MinAmount = 100000, Duration = 10, Enabled = true },
{ Name = "Level4", MinAmount = 500000, Duration = 15, Enabled = true },
},
}
 
Config.Thresholds = {
Nuke = 100,
Hammer = 100000,
BlackHole = 500000,
}
 
Config.LiveChat = {
Enabled = true,
RootName = "LiveChat",
WaitingText = "HTS KOK GALAU AOKAOKAOKAOK",
WaitingSender = "",
MaxChatLength = 200,
MaxNameLength = 40,
AvatarType = "HeadShot",
UpdateOnEmptyMessage = true,
EmptyMessageText = "Terima kasih atas dukungannya!",
}
 
Config.TopDonor = {
Enabled = true,
DataStoreName = "WX_SAWERIA_TOP_NO_LICENSE_V2",
NameStoreName = "WX_SAWERIA_TOP_NAMES_NO_LICENSE_V2",
MaxRows = 10,
}
 
Config.Discord = {
Enabled = false,
WebhookUrl = "https://discord.com/api/webhooks/-",
MinAmount = 0,
BotName = "WX Saweria",
BotAvatar = "",
ColorDefault = 5814783,
ColorNuke = 16744272,
ColorHammer = 16711680,
ColorBlackHole = 8978431,
}
 
Config.Positions = {
Nuke = {
Target = Vector3.new(-94, 0.5, -9),
},
Hammer = {
Target = Vector3.new(-94, 0.5, -9),
Text = Vector3.new(-94, 0.5, -9),
Spawn = Vector3.new(-94, 0.5, -9),
Impact = Vector3.new(-94, 0.5, -94),
},
BlackHole = {
Text = Vector3.new(-94, 0.5, -9),
Spawn = Vector3.new(-94, 0.5, -9),
Impact = Vector3.new(-94, 0.5, -94),
},
}
 
return Config
