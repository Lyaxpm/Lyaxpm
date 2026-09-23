-- WXClubKit > Config > GameConfig   (ModuleScript)

local GameConfig = {}

local RoleConfig = require(script.Parent:WaitForChild("RoleConfig"))

-- ── GAMEPASS IDs ─────────────────────────────
GameConfig.GAMEPASS = {
	VIP          = 1992884372,
	VVIP         = 1992512430,
	CUSTOM_TITLE = 1992776379,  
}

-- ── DEVELOPER PRODUCT IDs ────────────────────
GameConfig.DEVPRODUCT = {
	GIFT_VIP  = 1992776379,
	GIFT_VVIP = 3714333369,
}

GameConfig.GROUP_ID = 488009546  -- Roblox community/group id

-- ── ROLE DATA ALIASES (source: RoleConfig) ───
GameConfig.RANK          = RoleConfig.RANK
GameConfig.LEVEL         = RoleConfig.LEVEL
GameConfig.SPECIAL_ROLES = RoleConfig.SPECIAL_ROLES

-- ── DJ SOUNDS ────────────────────────────────
GameConfig.Sounds = {
	Success = 112486094040833,
	Fail    = 131661013076677,
}

local _DEFAULT_IMAGE = "rbxassetid://80615069806225"  -- default image for music/song covers
function GameConfig.getDefaultImage()
	return _DEFAULT_IMAGE
end

-- ── DJ EFFECTS ───────────────────────────────
GameConfig.Effects = {
	PlaybackSpeed = {
		Min          = 0.1,
		Max          = 4.0,
		Default      = 1.0,
		Presets      = { 0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0 },
		PresetLabels = { "0.25x", "0.5x", "0.75x", "1x", "1.25x", "1.5x", "2x" },
	},
	Pitch      = { Min = -12, Max = 12, Default = 0, Step = 1 },
	Reverb     = { Min = 0,   Max = 1,  Default = 0 },
	Echo       = { Min = 0,   Max = 1,  Default = 0 },
	Distortion = { Min = 0,   Max = 1,  Default = 0 },
	Chorus     = { Min = 0,   Max = 1,  Default = 0 },
}

-- ── DYNAMIC VOTE SKIP ────────────────────────
GameConfig.VoteSkip = {
	Mode        = "percentage",  -- "percentage" or "fixed"
	Percentage  = 0.30,          -- 30% of players in the server
	MinVotes    = 2,             -- minimum votes (prevents 1 player skipping in a small server)
	MaxVotes    = 50,            -- upper limit of required votes
	FixedAmount = 2,             -- used when Mode = "fixed"
}

-- ── DJ SETTINGS ──────────────────────────────
GameConfig.Settings = {
	VoteSkipAmount          = 2,
	VoteResetOnSkip         = true,
	LoopQueue               = true,
	MaxQueueSize            = 10,
	MaxQueueInsertPerPlayer = 2,
	DefaultVolume           = 2,
	DataStoreEnabled        = true,
	RequestCooldown         = 2,
	SyncOnJoin              = true,
	MusicZoneEnabled        = true,
	DJ_SKIP_BYPASS          = true,
	DJ_UNLIMITED_QUEUE      = true,
}

-- ── DJ DEFAULTS ──────────────────────────────
GameConfig.Defaults = {
	PlaybackSpeed = 1.0,
	Pitch         = 0,
	Reverb        = 0,
	Echo          = 0,
	Distortion    = 0,
	Chorus        = 0,
	IsPaused      = 0,
}

-- ── CREDITS ──────────────────────────────────
GameConfig.Credits = {
	HeaderImage  = _DEFAULT_IMAGE,
	HeaderHeight = 130,
	Sections = {
		{ label = "Development", type = "single", names = { "'0xGen'" } },
		{ label = "Moderation",  type = "grid",   names = { "-", "-" } },
		{ label = "Key Players", type = "player", prefix = "You" },
	},
	GroupId        = 488009546, 
	JoinGroupLabel = "Join Group",
	JoinGroupBtn   = "Join",
	DiscordLink    = "https://discord.gg/",
	DiscordLabel   = "Discord Server",
	DiscordBtn     = "Open",
}



-- ════════════════════════════════════════════
-- TIDAK PERLU EDIT DIBAWAH INI  \  NO NEED TO EDIT BELOW THIS
-- ════════════════════════════════════════════















































-- DJ username list, built from role data in RoleConfig.
local _DJ_RAW = {}

for name in pairs(RoleConfig.SPECIAL_ROLES) do
	table.insert(_DJ_RAW, name)
end
for _, name in ipairs(RoleConfig.ADMIN_NAMES) do
	table.insert(_DJ_RAW, name)
end
for name in pairs(RoleConfig.WHITELIST) do
	table.insert(_DJ_RAW, name)
end

local DJ_USERNAMES_LOWER = {}
for _, name in ipairs(_DJ_RAW) do
	DJ_USERNAMES_LOWER[name:lower()] = true
end

-- Role function aliases (source: RoleConfig)
GameConfig.rankOf                 = RoleConfig.rankOf
GameConfig.canUpgrade             = RoleConfig.canUpgrade
GameConfig.higherRole             = RoleConfig.higherRole
GameConfig.isAdmin                = RoleConfig.isAdmin
GameConfig.getWhitelistRole       = RoleConfig.getWhitelistRole
GameConfig.getSpecialRole         = RoleConfig.getSpecialRole
GameConfig.getSpecialRoleByName   = RoleConfig.getSpecialRoleByName
GameConfig.getSpecialRoleByUserId = RoleConfig.getSpecialRoleByUserId
GameConfig.getLevelFromPoints     = RoleConfig.getLevelFromPoints
GameConfig.getGiftRole            = RoleConfig.getGiftRole

-- DJ functions
function GameConfig.isDJ(username)
	if not username then return false end
	return DJ_USERNAMES_LOWER[username:lower()] == true
end

function GameConfig.getDJList()
	local list = {}
	for _, v in ipairs(_DJ_RAW) do table.insert(list, v) end
	return list
end

local _frozenDefault = nil
function GameConfig.getDefaultDJState()
	if not _frozenDefault then
		_frozenDefault = {}
		for k, v in pairs(GameConfig.Defaults) do
			_frozenDefault[k] = v
		end
	end
	local copy = {}
	for k, v in pairs(_frozenDefault) do copy[k] = v end
	return copy
end

-- Compute the number of skip votes required for the current player count.
function GameConfig.getRequiredVoteSkip(playerCount)
	local cfg = GameConfig.VoteSkip

	-- Fixed mode (or missing config) → use the exact value.
	if not cfg or cfg.Mode == "fixed" then
		return (cfg and cfg.FixedAmount) or GameConfig.Settings.VoteSkipAmount or 1
	end

	-- Percentage mode.
	playerCount = math.max(1, math.floor(playerCount or 1))

	local required = math.ceil(playerCount * (cfg.Percentage or 0.30))
	local minV     = cfg.MinVotes or 1
	local maxV     = cfg.MaxVotes or playerCount

	required = math.clamp(required, minV, math.max(minV, maxV))
	required = math.min(required, playerCount)  -- never require more than the player count

	return math.max(1, required)
end

-- ════════════════════════════════════════════
-- DATASTORE — actual store name is managed in DataStoreConfig ("MusicFavorites").
-- This field is a legacy fallback only; do NOT treat as source of truth.
-- ════════════════════════════════════════════
GameConfig.Settings.DataStoreKey = "WXMusic_Favorites_v1"

return GameConfig
