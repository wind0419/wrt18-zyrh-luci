-- Copyright 2014 Roger D <rogerdammit@gmail.com>
-- Licensed to the public under the Apache License 2.0.

module("luci.controller.zyrh-gi", package.seeall)

function index()
	require("luci.i18n")
	luci.i18n.loadc("zyrh_gi")
	if not nixio.fs.access("/etc/config/zyrh_gi") then
		return
	end

	local page = entry({"admin", "services", "zyrh_gi"}, cbi("zyrh-gi"), _("zyrh-gi"))
	page.i18n = "zyrh_gi"
	page.dependent = true

end
