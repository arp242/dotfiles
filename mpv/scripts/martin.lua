local io    = require "io"
local utils = require "mp.utils"

-- Use io.write as we don't want mpv to show a [martin]: message.

-- Hide cursor, and show it again on shutdown.
io.write("\x1b[?25l")
mp.register_event("shutdown", function() io.write("\x1b[?25h") end)

-- Pause before suspending; otherwise mpv will half-read some frame (or some
-- such) and audio/video is corrupted for a second on resume.  Also show cursor
-- on suspend, and hide it again on resume.
--
-- Also need to disable ^Z signal with function wrapper:
--   mpv() { stty susp '' &>/dev/null; =mpv $@; stty susp '^Z' &>/dev/null; }
mp.add_forced_key_binding("ctrl+z", "c-z", function()
	mp.command('set pause yes')
	io.write("\x1b[?25h\n")

	mp.add_timeout(1, function()
		io.write("\x1b[?25l\n")
		mp.command('set pause no')
	end)

	utils.subprocess({args = {'kill', '-TSTP', tostring(utils.getpid())}})
end)
