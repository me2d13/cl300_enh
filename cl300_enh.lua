print("Hello there, CL300 enhancment commands loaded")

cl_DR_ll1 = find_dataref("cl300/landlight1_h")
cl_DR_ll2 = find_dataref("cl300/landlight2_h")
cl_DR_taxi_light = find_dataref("cl300/xap_taxilight_h")
cl_DR_nav_light = find_dataref("cl300/nav_h")
cl_DR_strobe_light = find_dataref("cl300/strobe_h")
alt_select_DR = find_dataref("sim/cockpit2/autopilot/altitude_dial_ft")

beacon_is_on = 0
altitude_before_toggle = -1
altitude_low = 5000
altitude_high = 41000

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

function cl300_enh_alt_toggle(phase,duration)
	if phase == 0 then -- when command started
		if alt_select_DR == altitude_high then
			if altitude_before_toggle > 0 then
				-- altitude is high preselect and previous value is set, switch to previous
				alt_select_DR = altitude_before_toggle
			else
				-- altitude is high but no preselect value, just switch to low
				alt_select_DR = altitude_low
			end
		elseif alt_select_DR == altitude_low then
			if altitude_before_toggle > 0 then
				-- altitude is low preselect and previous value is set, switch to previous
				alt_select_DR = altitude_before_toggle
			else
				-- altitude is low but no preselect value, just switch to high
				alt_select_DR = altitude_high
			end
		else
			-- altitude is custom, determine the "farrer" preselect and switch to it
			altitude_before_toggle = alt_select_DR
			if math.abs(alt_select_DR - altitude_low) > math.abs(alt_select_DR - altitude_high) then
				alt_select_DR = altitude_low
			else
				alt_select_DR = altitude_high
			end
		end 
	end
end

create_command("cl300_enh/toggle_altitude_hold", "Switch autopilot altitude hold between current and 5000ft or FL410", cl300_enh_alt_toggle)


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
