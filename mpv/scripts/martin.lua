local io    = require "io"
local utils = require "mp.utils"

-- Use io.write as we don't want mpv to show a [martin]: message.
io.write("\x1b[?25l")
mp.register_event("shutdown", function() io.write("\x1b[?25h") end)

-- To allow mapping ^Z:
--    mpv() { stty susp ''; command mpv $@; stty susp '^Z'; }
mp.add_key_binding("ctrl+z", "c-z", function()
	-- Pause before suspending; otherwise mpv will half-read some frame (or some
	-- such) and audio/video is corrupted for a second on resume. 
	mp.command('set pause yes')
	io.write("\x1b[?25h\n")

	mp.add_timeout(1, function()
		io.write("\x1b[?25l\n")
		mp.command('set pause no')
	end)

	utils.subprocess({args = {'kill', '-TSTP', tostring(utils.getpid())}})
end)
