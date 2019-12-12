-- Copyright 2014 Roger D <rogerdammit@gmail.com>
-- Licensed to the public under the Apache License 2.0.

module("luci.controller.ipc-osd", package.seeall)

function index()
	require("luci.i18n")
	luci.i18n.loadc("ipc_osd")
	if not nixio.fs.access("/etc/config/ipc_osd") then
		return
	end

	local page = entry({"admin", "services", "ipc_osd"}, cbi("ipc-osd"), _("IPC-OSD"))
	page.i18n = "ipc_osd"
	page.dependent = true

end
