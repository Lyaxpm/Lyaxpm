-- ========================================
-- MODULE: Config  (Child of DonationServerHandler)
-- ========================================

local RunService = game:GetService("RunService")

local Config = {}

-- ── ENVIRONMENT ──────────────────────────────
Config.IS_STUDIO    = RunService:IsStudio()
Config.IS_TEST_MODE = Config.IS_STUDIO or game.PlaceId == 0

Config.DONATION_FIELD = Config.IS_TEST_MODE
	and "Donated - Studio"
	or  "Donated - Experience"









-- ── DEV PRODUCTS IDs ─────────────────────────────────
Config.PRODUCTS = {
	{ id = 3714336269, name = "PRICE 10",   price = 10   },
	{ id = 3714336432, name = "PRICE 50",   price = 50   },
	{ id = 3714336571, name = "PRICE 100",  price = 100  },
	{ id = 3714336706, name = "PRICE 200",  price = 200  },
	{ id = 3714337089, name = "PRICE 500",  price = 500  },
	{ id = 3714337441, name = "PRICE 1000", price = 1000 },
	{ id = 3714337239, name = "PRICE 1500", price = 1500 },
}









Config.PRODUCT_PRICES = {}
for _, product in ipairs(Config.PRODUCTS) do
	Config.PRODUCT_PRICES[product.id] = product.price
end

-- ── BROADCAST ────────────────────────────────
Config.BROADCAST = {
	ENABLED                = true,
	MIN_DONATION           = 1,  -- minimum donation required to use custom messages/live chat
	AUTO_MESSAGE_ENABLED   = false,
	AUTO_MESSAGE_THRESHOLD = 50,
	DISPLAY_DURATION       = 5,
	QUEUE_DELAY            = 0.5,
	MAX_MESSAGE_LENGTH     = 200,
	MAX_QUEUE              = 50,
	MAX_QUEUE_PER_PLAYER   = 3,
	COOLDOWN               = 10,
}

Config.AUTO_MESSAGES = {
	"Thank you for your support!",
	"Every donation means a lot!",
	"Thanks for donating!",
	"Your support helps a lot!",
	"Thank you so much!",
	"We appreciate your donation!",
}

-- ── DONATION EFFECT ──────────────────────────
Config.EFFECT = {
	DISPLAY_DURATION      = 10,
	LEVEL4_DURATION       = 10,
	MAX_STORED_DONATIONS  = 10,
	DONATION_STORAGE_TIME = 30,
}

-- PRICE RANGES → EFFECT
--   templateName   : Part name inside the "Level Effect" folder
--   cinematicCam   : true = everyone's camera focuses on the donor
--   effectDuration : (optional) effect duration; defaults to EFFECT.DISPLAY_DURATION
Config.PRICE_RANGES = {
	{ label = "Level 1", minPrice = 1, maxPrice = 99, templateName = "Level1", cinematicCam = false },
	{ label = "Level 2", minPrice = 100, maxPrice = 499, templateName = "Level2", cinematicCam = false },
	{ label = "Level 3", minPrice = 500, maxPrice = 99999, templateName = "Level3", cinematicCam = true  },
}

-- ── CINEMATIC CAM ────────────────────────────
Config.CINEMATIC_CAM = {
	ENABLED   = true,  -- master switch (false = disable for all levels)
	DURATION  = 8,     -- how long the camera focuses on the donor (seconds)
	DISTANCE  = 12,    -- camera distance from the donor (studs)
	HEIGHT    = 4,     -- camera height relative to the donor
	TWEEN_IN  = 1,     -- intro transition + black bar slide-in (seconds)
	TWEEN_OUT = 1,     -- outro transition + black bar close (seconds)
}

-- ── LIVE MESSAGE ─────────────────────────────
Config.LIVEMESSAGE = {
	DEFAULT_CHAT = "KATANYA HTS, KOK GALAU AWKAWKAWK",
}

-- ── LEADERBOARD ──────────────────────────────
Config.LEADERBOARD = {
	REFRESH_INTERVAL = 60,  -- leaderboard refresh time (seconds)
	TOP_ENTRIES      = 100,
	CACHE_DURATION   = 60,  -- seconds before the cache expires
}

-- ── DAILY TOTAL (WXDonateShopBoard) ──────────
Config.DAILY = {
	TIMEZONE_OFFSET  = 7,
	REFRESH_INTERVAL = 30,
}

-- ── SECURITY ─────────────────────────────────
Config.SECURITY = {
	TRACK_PURCHASES  = not Config.IS_TEST_MODE,
	PURCHASE_TIMEOUT = 300,
	KICK_ON_FAKE     = false,
}

-- ── DEBUG ────────────────────────────────────
Config.DEBUG = {
	ENABLED        = false,
	SHOW_DATASTORE = true,
	SHOW_RECEIPT   = true,
	SHOW_BROADCAST = true,
	SHOW_ERRORS    = true,
}

-- ── SOUNDS ───────────────────────────────────
Config.SOUNDS = {
	ENABLED      = true,
	VOLUME       = 4,
	MAX_DISTANCE = 60,
	MIN_DISTANCE = 10,
	LEVEL_SOUNDS = {
		["Level 1"] = 140164956768679,
		["Level 2"] = 125616422273831,
		["Level 3"] = 140353635763902,
		["Level 4"] = 140353635763902,
	},
}













-- ════════════════════════════════════════════
-- TIDAK PERLU EDIT DIBAWAH INI  \  NO NEED TO EDIT BELOW THIS
-- ════════════════════════════════════════════







Config.DATASTORE = {
	NAME           = "Donation Board // V3 - Data",  
	KEY            = "Donations",
	SCOPE          = "global",
	RETRY_ATTEMPTS = 3,
	RETRY_DELAY    = 1,
	SAVE_COOLDOWN  = 5,
}

Config.DAILY.DATASTORE_NAME = "WXDonation_DailyTotal"  

return Config