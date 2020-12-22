-- Copyright 2014 Roger D <rogerdammit@gmail.com>
-- Licensed to the public under the Apache License 2.0.

m = Map("ipc_osd", "IPC-OSD", translate("ipc osd service is working to get/set ipc osd text"))

--- General settings ---

section_gen = m:section(TypedSection, "ipc_osd", translate("General"))
    section_gen.addremove=false
    section_gen.anonymous=true

enabled = section_gen:option(Flag, "enabled", "Enabled", translate("Enable ipc-osd"))

host = section_gen:option(Value, "osd_ip",  translate("ipc ip addr"))
    host:depends("enabled", "1")
    host.optional = false

port = section_gen:option(Value, "osd_port", translate("ipc port"))
    port:depends("enabled", "1")
    port.datatype = "port"
    port.placeholder = "11000"
    port.optional = false

username = section_gen:option(Value, "username", translate("Username"))
    username:depends("enabled", "1")
    username.optional = false

password = section_gen:option(Value, "password", translate("Password"))
    password:depends("enabled", "1")
    password.password = true
    password.optional = false

gps_enabled = section_gen:option(Flag, "gps_enabled", translate("gps enabled"))
    gps_enabled:depends("enabled", "1")

osd_enabled = section_gen:option(Flag, "osd_enabled", translate("osd enabled"))
    osd_enabled:depends("enabled", "1")

fpm = section_gen:option(Value, "osd_fpm", translate("Flush per minute"))
    fpm:depends("osd_enabled", "1")
    fpm.datatype = "and(uinteger, min(1))"
    fpm.placeholder = "1"
    fpm.optional = false

elec_k = section_gen:option(Value, "elec_k", translate("ELEC_K"))
    elec_k:depends("enabled", "1")
    elec_k.optional = false

elec_b = section_gen:option(Value, "elec_b", translate("ELEC_B"))
    elec_b:depends("enabled", "1")
    elec_b.optional = false

elec_html = [[
<div id="elecdiv">
	<p>电压(V)  电量斜率  电量常数</p>
	<p>20-25.5   18.18    -363.64</p>
	<p>8-12.5    22.22    -177.78</p>
	<p>9-12.5    28.57    -257.14</p>
	<p>10.8-14   31.25    -337.5</p>
</div>
]]

elec_tb = section_gen:option(DummyValue, "_dummy", elec_html)
    elec_tb:depends("osd_enabled", "1")

--text = section_gen:option(Value, "osd_content", "osd text content")
--    text:depends("osd_enabled", "1")
--    text.optional = false

html = [[
<style media="screen" type="text/css">
    .img-preview {
        display: inline-block;
        height: auto;
        width: 640px;
        padding: 4px;
        line-height: 1.428571429;
        background-color: #fff;
        border: 1px solid #ddd;
        border-radius: 4px;
        -webkit-transition: all .2s ease-in-out;
        transition: all .2s ease-in-out;
        margin-bottom: 5px;
    }
</style>

<div id="videodiv">
	<img id="video_preview" class="img-preview" src="/cur.jpg"/>
</div>
]]


preview = section_gen:option(DummyValue, "_dummy", html)
    preview:depends("osd_enabled", "1")

--preview = s:taboption(this_tab, DummyValue, "_dummy", html)

return m
