
local fs = require "nixio.fs"
local m,s,olt,opt,port,preview
local val 
local info_val

m = Map("ipc_cfg", translate("IPC"), translate("Setting IPC args"))
s = m:section(TypedSection, "ipc_cfg", translate("IPC args"))
s.addremove = false
s.anonymous = true
s:tab("netset1", translate("IPC args"))

this_tab = "netset1"
opt = s:taboption(this_tab, Flag, "enable", translate("Enable"))
opt.rmempty = false

opt = s:taboption(this_tab, Flag, "tx_on_4g", translate("Enable tx on 4G"))
opt.rmempty = false
opt:depends("enable", "1")

opt = s:taboption(this_tab, Value, "ipaddr", translate("IPC Ipaddr"))
opt.datatype = "ip4addr"
opt.placeholder = "192.168.1.10"
opt:depends("enable", "1")

port = s:taboption(this_tab, Value, "port", translate("IPC Port"))
port.placeholder = "34567"
port.datatype    = "port"
port:depends("enable", "1")

opt = s:taboption(this_tab, ListValue, "search_type", translate("Video Type"))
opt:depends("enable", "1")
opt.default = 1
opt:value(0, translate("ALL Video"))
opt:value(1, translate("ALARM Video"))
opt:value(2, translate("DETECT Video"))
opt:value(3, translate("REGULAR Video"))
opt:value(4, translate("MANUAL Video"))
opt:value(5, translate("KEY Video"))


--- HTTP preview  ---
html_h = [[
<div>
<p>IPC History Record:</p>
<textarea style="font-size: 12px; width: 640px; height: 320px;" readonly="readonly" wrap="off" id="record">
]]
html_t= [[
</textarea></div>
]]

info_val = fs.readfile("/tmp/record_info") or ""
val = html_h..info_val..html_t
preview = s:taboption(this_tab, DummyValue, "_dummy", val)
preview:depends("enable", "1")

local apply = luci.http.formvalue("cbi.apply")

return m
