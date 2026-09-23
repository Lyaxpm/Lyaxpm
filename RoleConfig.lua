-- WXClubKit > Config > RoleConfig   (ModuleScript)

local RoleConfig = {}

local WHITE = Color3.fromRGB(255, 255, 255)

-- ── ROLE RANK ────────────────────────────────
RoleConfig.RANK = {
	Normal = 0,
	Member = 1,
	VIP    = 2,
	VVIP   = 3,
}

-- ── LEVEL SYSTEM (used by RankUIHandler & overhead) ──
RoleConfig.LEVEL = {
	PointsPerLevel = 100,    -- points required to level up by 1
	Prefix         = "Lv.",  -- overhead prefix, e.g. "Lv." → "Lv.5"
	StartLevel     = 1,      -- starting level when points = 0
}

RoleConfig.SHOW_CORE_LEADERBOARD = true

-- ── SPECIAL ROLES (membership: username → role) ──
RoleConfig.SPECIAL_ROLES = {
	["GenAvatarAgin"]		 = "Owner",
	["username1"]		 = "Owner",
	["username2"]    	  = "CoOwner",
	["username3"]		   = "Developer",
}

RoleConfig.ADMIN_NAMES = {
	"GenAvatarAgin",
}

RoleConfig.WHITELIST = {}

-- ── OVERHEAD VISIBILITY ──────────────────────
RoleConfig.OVERHEAD = {
	ShowImageStatus = true,  -- true = show the icon bar (device/rank/flag/etc)
}

-- ── TOP DONOR ROLES (statusTitle1 badge) ─────
-- Active only if the player has no higher-priority special role.
-- Set Enabled = false to disable entirely.
RoleConfig.TOP_DONOR_ROLES = {
	Enabled = true,
	[1] = { Text = "#1 Donor", TextColor = Color3.fromRGB(255, 255, 255), BgColor = Color3.fromRGB(255, 255, 0),   Priority = 80 },
	[2] = { Text = "#2 Donor", TextColor = Color3.fromRGB(255, 255, 255), BgColor = Color3.fromRGB(120, 135, 160), Priority = 80 },
	[3] = { Text = "#3 Donor", TextColor = Color3.fromRGB(255, 255, 255), BgColor = Color3.fromRGB(166, 95, 54),   Priority = 80 },
}

RoleConfig.TOP_SAWER_ROLES = {
	Enabled = true,
	[1] = { Text = "Top1 Sawer", TextColor = Color3.fromRGB(255, 255, 255), BgColor = Color3.fromRGB(255, 215, 0),   Priority = 81 },
	[2] = { Text = "Top2 Sawer", TextColor = Color3.fromRGB(255, 255, 255), BgColor = Color3.fromRGB(170, 180, 200), Priority = 81 },
	[3] = { Text = "Top3 Sawer", TextColor = Color3.fromRGB(255, 255, 255), BgColor = Color3.fromRGB(190, 110, 60),  Priority = 81 },
}

-- ── DEFAULT SPECIAL ROLE DISPLAY (statusTitle1 badge) ──
-- Priority: higher value takes precedence when a player has multiple roles.
RoleConfig.SpecialRoles = {
	Owner     = { Text = "OWNER",     TextColor = WHITE, BgColor = Color3.fromRGB(0, 170, 0),   Priority = 100 },
	CoOwner   = { Text = "CO OWNER",  TextColor = WHITE, BgColor = Color3.fromRGB(0, 115, 173), Priority = 90  },
	Developer = { Text = "DEVELOPER", TextColor = WHITE, BgColor = Color3.fromRGB(0, 170, 0),   Priority = 80  },
	Admin     = { Text = "ADMIN",     TextColor = WHITE, BgColor = Color3.fromRGB(173, 0, 87),  Priority = 70  },
}

-- ── REGULAR RANK DISPLAY (overhead "Rank" label → "Guest | Lv.5") ──
RoleConfig.Ranks = {
	Guest  = { Text = "GUEST",  TextColor = Color3.fromRGB(255, 255, 255), BgColor = Color3.fromRGB(60, 65, 80)   },
	Member = { Text = "MEMBER", TextColor = Color3.fromRGB(170, 170, 255), BgColor = Color3.fromRGB(30, 80, 180)  },
	VIP    = { Text = "VIP",    TextColor = Color3.fromRGB(255, 185, 23),  BgColor = Color3.fromRGB(212, 175, 55) },
	VVIP   = { Text = "VVIP",   TextColor = Color3.fromRGB(0, 251, 255),   BgColor = Color3.fromRGB(0, 170, 255)  },
}

-- ── CUSTOM ROLES (add as many as you like) ───
RoleConfig.CustomRoles = {
	{
		Name      = "Streamer",
		Text      = "YT Streamer",
		TextColor = Color3.fromRGB(255, 255, 255),
		BgColor   = Color3.fromRGB(128, 0, 255),
		Priority  = 1000,
		Usernames = { "username2", "username1" },
		UserIds   = {},
	},

	-- Example of adding another custom role:
	-- {
	-- 	Name      = "Tester",
	-- 	Text      = "TESTER",
	-- 	TextColor = Color3.fromRGB(0, 0, 0),
	-- 	BgColor   = Color3.fromRGB(255, 200, 0),
	-- 	Priority  = 40,
	-- 	Usernames = { "playername1" },
	-- 	UserIds   = { 123456789 },
	-- },
}

-- ── LEADERSTATS CONFIG ───────────────────────
RoleConfig.LEADERSTATS = {
	LIKES  = { ENABLED = true,  STAT_NAME = "Likes"  },
	DONATE = { ENABLED = true,  STAT_NAME = "Donate", COMBINE_BOTH = true },
	LEVEL  = { ENABLED = false, STAT_NAME = "Level"  },
	ORDER  = { "LIKES", "DONATE", "LEVEL" },  -- display order in CoreGui (index 1 = topmost)
}






-- ════════════════════════════════════════════
-- TIDAK PERLU EDIT DIBAWAH INI  \  NO NEED TO EDIT BELOW THIS
-- ════════════════════════════════════════════









































-- Internal lookups (built once on module load)
local _adminSet = {}
for _, name in ipairs(RoleConfig.ADMIN_NAMES) do
	_adminSet[name:lower()] = true
end

local _specialByName = {}
for name, role in pairs(RoleConfig.SPECIAL_ROLES) do
	_specialByName[name:lower()] = role
end

local _whitelistByName = {}
for name, role in pairs(RoleConfig.WHITELIST) do
	_whitelistByName[name:lower()] = role
end

local _customByUsername = {}
local _customByUserId   = {}
local function _consider(map, key, role)
	local existing = map[key]
	if not existing or (role.Priority or 0) > (existing.Priority or 0) then
		map[key] = role
	end
end
for _, role in ipairs(RoleConfig.CustomRoles) do
	if type(role.Usernames) == "table" then
		for _, u in ipairs(role.Usernames) do
			if type(u) == "string" and u ~= "" then
				_consider(_customByUsername, u:lower(), role)
			end
		end
	end
	if type(role.UserIds) == "table" then
		for _, id in ipairs(role.UserIds) do
			if type(id) == "number" then
				_consider(_customByUserId, id, role)
			end
		end
	end
end

-- ── RANK / UPGRADE ───────────────────────────
function RoleConfig.rankOf(role)
	return RoleConfig.RANK[role] or 0
end

function RoleConfig.canUpgrade(currentRole, newRole)
	return (RoleConfig.RANK[newRole] or 0) > (RoleConfig.RANK[currentRole] or 0)
end

function RoleConfig.higherRole(roleA, roleB)
	if (RoleConfig.RANK[roleA] or 0) >= (RoleConfig.RANK[roleB] or 0) then
		return roleA
	end
	return roleB
end

-- ── ADMIN / SPECIAL / WHITELIST ──────────────
function RoleConfig.isAdmin(player)
	if not player then return false end
	local n = player.Name:lower()
	if _adminSet[n] == true or _specialByName[n] ~= nil then return true end
	local gift = RoleConfig.getGiftRole(player)
	if gift then
		if gift.kind == "preset" then return true end
		if gift.kind == "custom" and gift.adminAccess then return true end
	end
	return false
end

function RoleConfig.getWhitelistRole(player)
	if not player then return nil end
	return _whitelistByName[player.Name:lower()]
end

function RoleConfig.getGiftRole(player)
	if not player then return nil end
	local kind = player:GetAttribute("GR_Kind")
	if kind == "preset" then
		local preset = player:GetAttribute("GR_Preset")
		if preset and RoleConfig.SpecialRoles[preset] then
			return { kind = "preset", preset = preset }
		end
	elseif kind == "custom" then
		local text = player:GetAttribute("GR_Text")
		if text and text ~= "" then
			return {
				kind        = "custom",
				text        = text,
				textColor   = player:GetAttribute("GR_TextColor") or Color3.fromRGB(255, 255, 255),
				bgColor     = player:GetAttribute("GR_BgColor")   or Color3.fromRGB(120, 120, 120),
				priority    = tonumber(player:GetAttribute("GR_Priority")) or 500,
				adminAccess = player:GetAttribute("GR_AdminAccess") == true,
			}
		end
	end
	return nil
end

function RoleConfig.getSpecialRole(player)
	if not player then return nil end
	local n = player.Name:lower()
	local sr = _specialByName[n]
	if sr then return sr end
	if _adminSet[n] then return "Admin" end
	local gift = RoleConfig.getGiftRole(player)
	if gift and gift.kind == "preset" then return gift.preset end
	return nil
end

function RoleConfig.getSpecialRoleByName(username)
	if not username then return nil end
	local n = username:lower()
	local sr = _specialByName[n]
	if sr then return sr end
	if _adminSet[n] then return "Admin" end
	return nil
end

function RoleConfig.getSpecialRoleByUserId(_userId)
	return nil
end

-- ── LEVEL ────────────────────────────────────
function RoleConfig.getLevelFromPoints(points)
	local cfg = RoleConfig.LEVEL or {}
	points = tonumber(points) or 0
	if points < 0 then points = 0 end
	local per = cfg.PointsPerLevel
	if type(per) ~= "number" or per <= 0 then per = 100 end
	local startLvl = cfg.StartLevel or 1
	return math.floor(points / per) + startLvl
end

-- ── CORE LEADERBOARD ─────────────────────────
function RoleConfig.applyCoreLeaderboard(enabled)
	if enabled == nil then enabled = RoleConfig.SHOW_CORE_LEADERBOARD end
	enabled = enabled and true or false

	local RunService = game:GetService("RunService")
	if not RunService:IsClient() then
		return false
	end

	local StarterGui = game:GetService("StarterGui")

	for _ = 1, 10 do
		local ok = pcall(function()
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, enabled)
		end)
		if ok then return true end
		task.wait(0.2)
	end
	return false
end

-- ── DISPLAY ──────────────────────────────────
function RoleConfig.getRankDisplay(rankName)
	return RoleConfig.Ranks[rankName] or RoleConfig.Ranks.Guest
end

function RoleConfig.getCustomRole(player)
	if not player then return nil end
	local byId = _customByUserId[player.UserId]
	if byId then return byId end
	return _customByUsername[player.Name:lower()]
end

-- getBadge(player, topDonorRank)
--   topDonorRank : 1/2/3 if the player is a top donor, nil otherwise.
--   Supplied by RankUIHandler; RoleConfig itself has no DataStore access.
function RoleConfig.getBadge(player, topDonorRank)
	if not player then return nil end

	local best, bestName, bestPri = nil, nil, -math.huge

	local sr = RoleConfig.getSpecialRole(player)
	if sr then
		local cfg = RoleConfig.SpecialRoles[sr]
		if cfg then best, bestName, bestPri = cfg, sr, (cfg.Priority or 0) end
	end

	local custom = RoleConfig.getCustomRole(player)
	if custom and (custom.Priority or 0) > bestPri then
		best, bestName, bestPri = custom, custom.Name, (custom.Priority or 0)
	end

	local giftRole = RoleConfig.getGiftRole(player)
	if giftRole and giftRole.kind == "custom" and (giftRole.priority or 0) > bestPri then
		best = { Text = giftRole.text, TextColor = giftRole.textColor, BgColor = giftRole.bgColor, Priority = giftRole.priority }
		bestName, bestPri = "GiftCustom", (giftRole.priority or 0)
	end

	-- Top donor badge: only when Enabled and rank is valid (1/2/3)
	local tdCfg = RoleConfig.TOP_DONOR_ROLES
	if tdCfg and tdCfg.Enabled and topDonorRank then
		local rankCfg = tdCfg[topDonorRank]
		if rankCfg and (rankCfg.Priority or 0) > bestPri then
			best, bestName, bestPri = rankCfg, "TopDonor" .. tostring(topDonorRank), (rankCfg.Priority or 0)
		end
	end

	-- Top sawer badge: rank dibaca dari attribute CT_TopSawerRank (di-set RankUIHandler bila WX Saweria ada)
	local tsCfg = RoleConfig.TOP_SAWER_ROLES
	if tsCfg and tsCfg.Enabled then
		local rawSawer = player:GetAttribute("CT_TopSawerRank")
		local topSawerRank = (type(rawSawer) == "number" and rawSawer >= 1 and rawSawer <= 3) and rawSawer or nil
		if topSawerRank then
			local rankCfg = tsCfg[topSawerRank]
			if rankCfg and (rankCfg.Priority or 0) > bestPri then
				best, bestName, bestPri = rankCfg, "TopSawer" .. tostring(topSawerRank), (rankCfg.Priority or 0)
			end
		end
	end

	if best then return bestName, best end
	return nil
end

-- ── LEADERSTATS (called from SERVER) ─────────
function RoleConfig.applyLeaderstats(player, values)
	if not player or not player.Parent then
		return false, "Invalid player"
	end

	local RunService = game:GetService("RunService")
	if not RunService:IsServer() then
		return false, "applyLeaderstats must be called from the server"
	end

	values = values or {}
	local cfg = RoleConfig.LEADERSTATS

	local folder = player:FindFirstChild("leaderstats")
	if not folder then
		folder        = Instance.new("Folder")
		folder.Name   = "leaderstats"
		folder.Parent = player
	end

	local function upsertStat(statName, value)
		local stat = folder:FindFirstChild(statName)
		if not stat then
			stat        = Instance.new("IntValue")
			stat.Name   = statName
			stat.Parent = folder
		end
		stat.Value = math.floor(math.max(0, tonumber(value) or 0))
	end

	local levelEnabled = cfg.LEVEL.ENABLED
		and (RoleConfig.LEVEL.ShowInLeaderboard ~= false)

	for _, key in ipairs(cfg.ORDER) do
		if key == "LIKES" and cfg.LIKES.ENABLED and values.likes ~= nil then
			upsertStat(cfg.LIKES.STAT_NAME, tonumber(values.likes) or 0)
		elseif key == "DONATE" and cfg.DONATE.ENABLED and values.donate ~= nil then
			upsertStat(cfg.DONATE.STAT_NAME, tonumber(values.donate) or 0)
		elseif key == "LEVEL" and levelEnabled and values.level ~= nil then
			upsertStat(cfg.LEVEL.STAT_NAME, tonumber(values.level) or 0)
		end
	end

	return true
end

return RoleConfig