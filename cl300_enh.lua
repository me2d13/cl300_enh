print("Hello there, CL300 enhancment commands loaded")

cl_DR_ll1 = find_dataref("cl300/landlight1_h")
cl_DR_ll2 = find_dataref("cl300/landlight2_h")
cl_DR_taxi_light = find_dataref("cl300/xap_taxilight_h")
cl_DR_nav_light = find_dataref("cl300/nav_h")
cl_DR_strobe_light = find_dataref("cl300/strobe_h")

beacon_is_on = 0

function cl300_enh_landing_lights(val)
	cl_DR_ll1 = val
	cl_DR_ll2 = val
	cl_DR_taxi_light = val*2
end

function cl300_enh_landing_lights_on_CMDhandler(phase,duration)
	if phase == 0 then cl300_enh_landing_lights(1) end
end

function cl300_enh_landing_lights_off_CMDhandler(phase,duration)
	if phase == 0 then cl300_enh_landing_lights(0) end
end

function cl300_enh_taxi_lights_on_CMDhandler(phase,duration)
	if phase == 0 then cl_DR_taxi_light = 1	end
end

function cl300_enh_taxi_lights_off_CMDhandler(phase,duration)
	if phase == 0 then cl_DR_taxi_light = 0	end
end

function cl300_enh_bcn_light_on_CMDhandler(phase,duration)
	if phase == 0 then 
		cl_DR_strobe_light = 1 
		beacon_is_on = 1
	end
end

function cl300_enh_bcn_light_off_CMDhandler(phase,duration)
	if phase == 0 then 
		cl_DR_strobe_light = 0 
		beacon_is_on = 0
	end
end

function cl300_enh_strobe_light_on_CMDhandler(phase,duration)
	if phase == 0 then cl_DR_strobe_light = 2 end
end

function cl300_enh_strobe_light_off_CMDhandler(phase,duration)
	if phase == 0 then cl_DR_strobe_light = beacon_is_on end
end

function cl300_enh_nav_light_on_CMDhandler(phase,duration)
	if phase == 0 then cl_DR_nav_light = 1 end
end

function cl300_enh_nav_light_off_CMDhandler(phase,duration)
	if phase == 0 then cl_DR_nav_light = 0 end
end



replace_command("sim/lights/landing_lights_on", cl300_enh_landing_lights_on_CMDhandler) 
replace_command("sim/lights/landing_lights_off", cl300_enh_landing_lights_off_CMDhandler) 
replace_command("sim/lights/taxi_lights_on", cl300_enh_taxi_lights_on_CMDhandler)
replace_command("sim/lights/taxi_lights_off", cl300_enh_taxi_lights_off_CMDhandler)
replace_command("sim/lights/beacon_lights_on", cl300_enh_bcn_light_on_CMDhandler)
replace_command("sim/lights/beacon_lights_off", cl300_enh_bcn_light_off_CMDhandler)
replace_command("sim/lights/strobe_lights_on", cl300_enh_strobe_light_on_CMDhandler)
replace_command("sim/lights/strobe_lights_off", cl300_enh_strobe_light_off_CMDhandler)
replace_command("sim/lights/nav_lights_on", cl300_enh_nav_light_on_CMDhandler)
replace_command("sim/lights/nav_lights_off", cl300_enh_nav_light_off_CMDhandler)
