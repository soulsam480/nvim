local M = {}

local now_playing = "🎵 No music playing"

local function update_now_playing()
	local handle = io.popen("nowplaying-cli get-raw 2>/dev/null")

	if handle then
		local result = handle:read("*a")
		handle:close()
		if result and result ~= "" then
			local sanitized_str = result:gsub('\\"', "")

			local title = sanitized_str:match('kMRMediaRemoteNowPlayingInfoTitle%s*=%s*"([^"]+)"')

			if title then
				now_playing = "🎵 " .. title
			else
				now_playing = "🎵 No music playing"
			end
		end
	end
end

-- Update every 3 minutes (180,000 ms)
vim.defer_fn(function()
	update_now_playing()
	vim.loop.new_timer():start(0, 30000, vim.schedule_wrap(update_now_playing))
end, 1000)

M.now_playing_component = function()
	return now_playing
end

return M
