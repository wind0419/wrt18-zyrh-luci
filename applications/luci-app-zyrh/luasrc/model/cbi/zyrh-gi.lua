-- Copyright 2014 Roger D <rogerdammit@gmail.com>
-- Licensed to the public under the Apache License 2.0.
local fs = require "nixio.fs"

m = Map("zyrh_gi", "zyrh-gi", translate("zyrh i1 app"))

--- General settings ---

section_gen = m:section(TypedSection, "zyrh_gi", translate("General"))
    section_gen.addremove=false
    section_gen.anonymous=true

enabled = section_gen:option(Flag, "enabled", "Enable", translate("Enable gi"))

host = section_gen:option(Value, "ip",  translate("IP"))
    host:depends("enabled", "1")
    host.optional = false

port = section_gen:option(Value, "port", translate("port"))
    port:depends("enabled", "1")
    port.datatype = "port"
    port.optional = false

username = section_gen:option(Value, "id", translate("devid"))
    username:depends("enabled", "1")
    username.optional = false

password = section_gen:option(Value, "heartbeat", translate("heartbeat"))
    password:depends("enabled", "1")
    password.optional = false

st_dur = section_gen:option(Value, "start_duration", translate("start_duration"))
    st_dur:depends("enabled", "1")

gps_enabled = section_gen:option(Value, "capture_interval", translate("capture_interval"))
    gps_enabled:depends("enabled", "1")

st_t = section_gen:option(Value, "start_time", translate("start_time"))
    st_t:depends("enabled", "1")

osd_enabled = section_gen:option(Value, "end_time", translate("end_time"))
    osd_enabled:depends("enabled", "1")

fpm = section_gen:option(Value, "work_mode", translate("work_mode"))
    fpm:depends("enabled", "1")

elec_k = section_gen:option(DummyValue, "camera_status", translate("camera_status"))
    elec_k.default="init..."
    elec_k:depends("enabled", "1")

function elec_k.cfgvalue(...)
    return fs.readfile("/tmp/camera_status_1.log") or "init..."
end

elec_b = section_gen:option(DummyValue, "server_status", translate("server_status"))
    elec_b:depends("enabled", "1")
    elec_b.default="init..."

function elec_b.cfgvalue(...)
    return fs.readfile("/tmp/server_status_1.log") or "init..."
end

return m
