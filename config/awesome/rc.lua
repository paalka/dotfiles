if string.sub(awesome.version, 1, 2) == "v4" then
  local config = require("new.rc")
else
  local config = require("old.rc")
end
