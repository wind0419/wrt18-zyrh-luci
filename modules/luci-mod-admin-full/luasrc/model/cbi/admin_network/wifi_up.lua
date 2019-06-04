-- Copyright 2008 Steven Barth <steven@midlink.org>
-- Copyright 2008-2013 Jo-Philipp Wich <jow@openwrt.org>
-- Licensed to the public under the Apache License 2.0.

local fs = require "nixio.fs"
local upinfo = "/etc/wifi_up_list" 

f = SimpleForm("wifi_up", translate("WIFI UP"),
	translate("every line is a ap info,eg: ssid key"))

t = f:field(TextValue, "crons")
t.rmempty = true
t.rows = 5
function t.cfgvalue()
	return fs.readfile(upinfo) or ""
end

function f.handle(self, state, data)
	if state == FORM_VALID then
		if data.crons then
			fs.writefile(upinfo, data.crons:gsub("\r\n", "\n"))
			luci.sys.call("killall -usr2 ap_client")
			--luci.sys.call("/usr/bin/ap_client %q" % upinfo)
		else
			fs.writefile(upinfo, "")
		end
	end
	return true
end

return f
