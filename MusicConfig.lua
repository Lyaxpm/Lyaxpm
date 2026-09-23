--[[
    WXMusic ▸ DJConfig ▸ MusicConfig   (ModuleScript)
    ═══════════════════════════════════════════════════
]]


--[[ TEMPLATE PLAYLIST
  ═══════════════════════════════════════════════════
  
{
	Name  = "Playlist Template",
	Songs = {


		{
			Name          = "Music1",
			Artist        = "WrexDev Band",
			SoundId       = 100274294775085,
			ImageId       = "rbxassetid://102699953082481",
			PlaybackSpeed = 2.3,
		},
		{
			Name          = "Music2",
			Artist        = "WrexDev Band",
			SoundId       = 100274294775085,
			ImageId       = "rbxassetid://102699953082481",
			PlaybackSpeed = 1,
		},
	}
},

  ═══════════════════════════════════════════════════
]]


local MusicConfig = {
	Playlists = {


		{
			Name  = "Galau Era",
			Songs = {

				{
					Name          = "Sesi Potret",
					Artist        = "Five Second",
					SoundId       = 94643351699607,
					ImageId       = "rbxassetid://80615069806225",
					PlaybackSpeed = 0.4,
				},
				{
					Name = "Duka",
					Artist = "Five Second",
					SoundId = 136034890083388,
					ImageId = "rbxassetid://90925421064972",
					PlaybackSpeed = 0.4,
				},
			}
		},
		

	}
}

return MusicConfig