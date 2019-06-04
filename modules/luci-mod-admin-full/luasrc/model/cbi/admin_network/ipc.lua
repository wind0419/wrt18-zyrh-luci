
local fs = require "nixio.fs"
local m,s,olt,opt

m = Map("ipc_cfg", translate("IPC"), translate("Setting IPC args"))
s = m:section(TypedSection, "ipc_cfg", translate("IPC args"))
s.addremove = false
s.anonymous = true
s:tab("netset1", translate("IPC args"))

this_tab = "netset1"
o = s:taboption(this_tab, Flag, "enable", translate("Enable"))
o.rmempty = false

opt = s:taboption(this_tab, Value, "ipaddr", translate("IPC Ipaddr"))
opt.datatype = "ip4addr"
opt.placeholder = "192.168.1.10"
opt:depends("enable", "1")

opt = s:taboption(this_tab, Value, "port", translate("IPC Port"))
opt.placeholder = "34567"
opt.datatype    = "port"
opt:depends("enable", "1")

--opt = s:taboption(this_tab, DummyValue, "gps_info", translate("GPS Info"))
--opt.default="init..."
--opt:depends("enable", "1")
--function opt.cfgvalue(...)
--	return fs.readfile("/tmp/gps_info") or "init..."
--end

local apply = luci.http.formvalue("cbi.apply")
--if(apply) then
--	io.popen("/etc/init.d/net4g restart &")
--end

return m
