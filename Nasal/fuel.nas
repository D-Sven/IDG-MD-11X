# MD-11 Fuel System
# Joshua Davidson (it0uchpods)

##############################################
# Copyright (c) Joshua Davidson (it0uchpods) #
##############################################

setlistener("/sim/signals/fdm-initialized", func {
	var tank0pumps_sw = getprop("/controls/fuel/switches/tank0-pumps");
	var tank0xfeed_sw = getprop("/controls/fuel/switches/tank0-x-feed");
	var tank0fill_sw = getprop("/controls/fuel/switches/tank0-fill");
	var tank1pumps_sw = getprop("/controls/fuel/switches/tank1-pumps");
	var tank1xfeed_sw = getprop("/controls/fuel/switches/tank1-x-feed");
	var tank1fill_sw = getprop("/controls/fuel/switches/tank1-fill");
	var tank2pumps_sw = getprop("/controls/fuel/switches/tank2-pumps");
	var tank2xfeed_sw = getprop("/controls/fuel/switches/tank2-x-feed");
	var tank2fill_sw = getprop("/controls/fuel/switches/tank2-fill");
	var tank3ltrans_sw = getprop("/controls/fuel/switches/tank3-ltrans");
	var tank3rtrans_sw = getprop("/controls/fuel/switches/tank3-rtrans");
	var gload = getprop("/accelerations/pilot-gdamped");
	var system = getprop("/systems/fuel/system");
	var ac1 = getprop("/systems/electrical/bus/ac1");
	var ac2 = getprop("/systems/electrical/bus/ac2");
	var ac3 = getprop("/systems/electrical/bus/ac3");
	var manl = 0;
});

var FUEL = {
	init: func() {
		setprop("/controls/fuel/switches/tank0-pumps", 0);
		setprop("/controls/fuel/switches/tank0-x-feed", 0);
		setprop("/controls/fuel/switches/tank0-fill", 0);
		setprop("/controls/fuel/switches/tank1-pumps", 0);
		setprop("/controls/fuel/switches/tank1-x-feed", 0);
		setprop("/controls/fuel/switches/tank1-fill", 0);
		setprop("/controls/fuel/switches/tank2-pumps", 0);
		setprop("/controls/fuel/switches/tank2-x-feed", 0);
		setprop("/controls/fuel/switches/tank2-fill", 0);
		setprop("/controls/fuel/switches/tank3-ltrans", 0);
		setprop("/controls/fuel/switches/tank3-rtrans", 0);
		setprop("/controls/fuel/switches/manual-lt", 0);
		setprop("/controls/fuel/switches/manual-flash", 0);
		setprop("/systems/fuel/system", 1); # Automatic
		setprop("/systems/fuel/tank[0]/feed", 0);
		setprop("/systems/fuel/tank[0]/x-feed", 0);
		setprop("/systems/fuel/tank[1]/feed", 0);
		setprop("/systems/fuel/tank[1]/x-feed", 0);
		setprop("/systems/fuel/tank[2]/feed", 0);
		setprop("/systems/fuel/tank[2]/x-feed", 0);
		setprop("/systems/fuel/tank[3]/feed", 0);
		setprop("/systems/fuel/light/tank0-x-feed-disag", 0);
		setprop("/systems/fuel/light/tank1-x-feed-disag", 0);
		setprop("/systems/fuel/light/tank2-x-feed-disag", 0);
		setprop("/systems/fuel/light/tank0-pumps-low", 0);
		setprop("/systems/fuel/light/tank1-pumps-low", 0);
		setprop("/systems/fuel/light/tank2-pumps-low", 0);
		setprop("/systems/fuel/light/tank3-trans-low", 0);
		setprop("/systems/fuel/light/tank0-fill", 0);
		setprop("/systems/fuel/light/tank1-fill", 0);
		setprop("/systems/fuel/light/tank2-fill", 0);
		setprop("/systems/fuel/light/select-manual", 0);
	},
	loop: func() {
		tank0pumps_sw = getprop("/controls/fuel/switches/tank0-pumps");
		tank0xfeed_sw = getprop("/controls/fuel/switches/tank0-x-feed");
		tank0fill_sw = getprop("/controls/fuel/switches/tank0-fill");
		tank1pumps_sw = getprop("/controls/fuel/switches/tank1-pumps");
		tank1xfeed_sw = getprop("/controls/fuel/switches/tank1-x-feed");
		tank1fill_sw = getprop("/controls/fuel/switches/tank1-fill");
		tank2pumps_sw = getprop("/controls/fuel/switches/tank2-pumps");
		tank2xfeed_sw = getprop("/controls/fuel/switches/tank2-x-feed");
		tank2fill_sw = getprop("/controls/fuel/switches/tank2-fill");
		tank3ltrans_sw = getprop("/controls/fuel/switches/tank3-ltrans");
		tank3rtrans_sw = getprop("/controls/fuel/switches/tank3-rtrans");
		gload = getprop("/accelerations/pilot-gdamped");
		system = getprop("/systems/fuel/system");
		ac1 = getprop("/systems/electrical/bus/ac1");
		ac2 = getprop("/systems/electrical/bus/ac2");
		ac3 = getprop("/systems/electrical/bus/ac3");
		
		# FSC
		if (system) {
			if (getprop("/engines/engine[0]/state") != 0) {
				setprop("/controls/fuel/switches/tank0-pumps", 1);
			} else if (getprop("/controls/engines/ign-a") == 1 or getprop("/controls/engines/ign-b") == 1) {
				setprop("/controls/fuel/switches/tank0-pumps", 1);
			} else {
				setprop("/controls/fuel/switches/tank0-pumps", 0);
			}
			if (getprop("/engines/engine[1]/state") != 0) {
				setprop("/controls/fuel/switches/tank1-pumps", 1);
			} else if (getprop("/controls/engines/ign-a") == 1 or getprop("/controls/engines/ign-b") == 1) {
				setprop("/controls/fuel/switches/tank1-pumps", 1);
			} else {
				setprop("/controls/fuel/switches/tank1-pumps", 0);
			}
			if (getprop("/engines/engine[2]/state") != 0) {
				setprop("/controls/fuel/switches/tank2-pumps", 1);
			} else if (getprop("/controls/engines/ign-a") == 1 or getprop("/controls/engines/ign-b") == 1) {
				setprop("/controls/fuel/switches/tank2-pumps", 1);
			} else {
				setprop("/controls/fuel/switches/tank2-pumps", 0);
			}
			
			if (tank0xfeed_sw) {
				setprop("/controls/fuel/switches/tank0-x-feed", 0);
			}
			if (tank1xfeed_sw) {
				setprop("/controls/fuel/switches/tank1-x-feed", 0);
			}
			if (tank2xfeed_sw) {
				setprop("/controls/fuel/switches/tank2-x-feed", 0);
			}
			
			if (tank3ltrans_sw or tank3rtrans_sw) {
				setprop("/controls/fuel/switches/tank1-fill", 1);
			} else {
				setprop("/controls/fuel/switches/tank1-fill", 0);
			}
			
			if (getprop("/consumables/fuel/tank[1]/level-lbs") > 40000) {
				setprop("/controls/fuel/switches/tank0-fill", 1);
				setprop("/controls/fuel/switches/tank2-fill", 1);
			} else {
				setprop("/controls/fuel/switches/tank0-fill", 0);
				setprop("/controls/fuel/switches/tank2-fill", 0);
			}
			
			if (getprop("/consumables/fuel/tank[3]/level-lbs") > 70) {
				setprop("/controls/fuel/switches/tank3-ltrans", 1);
				setprop("/controls/fuel/switches/tank3-rtrans", 1);
			} else {
				setprop("/controls/fuel/switches/tank3-ltrans", 0);
				setprop("/controls/fuel/switches/tank3-rtrans", 0);
			}
		}
		
		if (!tank3ltrans_sw and !tank3rtrans_sw and !system) {
			if (tank1fill_sw == 1) {
				setprop("/controls/fuel/switches/tank1-fill", 0);
			}
		}
		
		if (getprop("/consumables/fuel/tank[1]/level-lbs") <= 40000 and !system) {
			if (tank0fill_sw == 1) {
				setprop("/controls/fuel/switches/tank0-fill", 0);
			}
			if (tank2fill_sw == 1) {
				setprop("/controls/fuel/switches/tank2-fill", 0);
			}
		}
		
		if ((ac1 >= 110 or ac2 >= 110 or ac3 >= 110) and tank0pumps_sw) {
			setprop("/systems/fuel/tank[0]/feed", 1);
		} else if (gload >= 0.7) {
			setprop("/systems/fuel/tank[0]/feed", 1);
		} else {
			setprop("/systems/fuel/tank[0]/feed", 0);
		}
		
		if ((ac1 >= 110 or ac2 >= 110 or ac3 >= 110) and tank1pumps_sw) {
			setprop("/systems/fuel/tank[1]/feed", 1);
		} else { # Engine 2 cannot gravity feed because it is above the tank
			setprop("/systems/fuel/tank[1]/feed", 0);
		}
		
		if ((ac1 >= 110 or ac2 >= 110 or ac3 >= 110) and tank2pumps_sw) {
			setprop("/systems/fuel/tank[2]/feed", 1);
		} else if (gload >= 0.7) {
			setprop("/systems/fuel/tank[2]/feed", 1);
		} else {
			setprop("/systems/fuel/tank[2]/feed", 0);
		}
		
		if ((ac1 >= 110 or ac2 >= 110 or ac3 >= 110) and (tank3ltrans_sw or tank3rtrans_sw)) {
			setprop("/systems/fuel/tank[3]/feed", 1);
		} else {
			setprop("/systems/fuel/tank[3]/feed", 0);
		}
		
		if (getprop("/consumables/fuel/tank[0]/level-lbs") <= 100 and tank0pumps_sw) {
			setprop("/systems/fuel/light/tank0-pumps-low", 1);
		} else {
			setprop("/systems/fuel/light/tank0-pumps-low", 0);
		}
		
		if (getprop("/consumables/fuel/tank[1]/level-lbs") <= 100 and tank1pumps_sw) {
			setprop("/systems/fuel/light/tank1-pumps-low", 1);
		} else {
			setprop("/systems/fuel/light/tank1-pumps-low", 0);
		}
		
		if (getprop("/consumables/fuel/tank[2]/level-lbs") <= 100 and tank2pumps_sw) {
			setprop("/systems/fuel/light/tank2-pumps-low", 1);
		} else {
			setprop("/systems/fuel/light/tank2-pumps-low", 0);
		}
		
		if (getprop("/consumables/fuel/tank[3]/level-lbs") <= 100 and (tank3ltrans_sw or tank3rtrans_sw)) {
			setprop("/systems/fuel/light/tank3-trans-low", 1);
		} else {
			setprop("/systems/fuel/light/tank3-trans-low", 0);
		}
		
		if (getprop("/fdm/jsbsim/fuel/tank0-is-filling") == 1 and tank0fill_sw) {
			setprop("/systems/fuel/light/tank0-fill", 1);
		} else {
			setprop("/systems/fuel/light/tank0-fill", 0);
		}
		
		if (getprop("/fdm/jsbsim/fuel/tank0-is-filling") == 1 and tank1fill_sw) {
			setprop("/systems/fuel/light/tank1-fill", 1);
		} else {
			setprop("/systems/fuel/light/tank1-fill", 0);
		}
		
		if (getprop("/fdm/jsbsim/fuel/tank0-is-filling") == 1 and tank2fill_sw) {
			setprop("/systems/fuel/light/tank2-fill", 1);
		} else {
			setprop("/systems/fuel/light/tank2-fill", 0);
		}
	},
	systemMode: func() {
		system = getprop("/systems/fuel/system");
		if (system) {
			setprop("/systems/fuel/system", 0);
			setprop("/controls/fuel/switches/manual-lt", 1);
		} else {
			setprop("/systems/fuel/system", 1);
			setprop("/controls/fuel/switches/manual-lt", 0);
		}
	},
	manualLight: func() {
		manl = getprop("/controls/fuel/switches/manual-flash");
		system = getprop("/systems/fuel/system");
		if (manl >= 5 or !system) {
			manualFuelLightt.stop();
			setprop("/controls/fuel/switches/manual-flash", 0);
		} else {
			setprop("/controls/fuel/switches/manual-flash", manl + 1);
		}
	},
};

setlistener("/controls/fuel/switches/tank0-x-feed", func {
	setprop("/systems/fuel/tank[0]/x-feed", getprop("/controls/fuel/switches/tank0-x-feed"));
	setprop("/systems/fuel/light/tank0-x-feed-disag", 1);
	settimer(func {
		setprop("/systems/fuel/light/tank0-x-feed-disag", 0);
	}, 1);
});

setlistener("/controls/fuel/switches/tank1-x-feed", func {
	setprop("/systems/fuel/tank[1]/x-feed", getprop("/controls/fuel/switches/tank1-x-feed"));
	setprop("/systems/fuel/light/tank1-x-feed-disag", 1);
	settimer(func {
		setprop("/systems/fuel/light/tank1-x-feed-disag", 0);
	}, 1);
});

setlistener("/controls/fuel/switches/tank2-x-feed", func {
	setprop("/systems/fuel/tank[2]/x-feed", getprop("/controls/fuel/switches/tank2-x-feed"));
	setprop("/systems/fuel/light/tank2-x-feed-disag", 1);
	settimer(func {
		setprop("/systems/fuel/light/tank2-x-feed-disag", 0);
	}, 1);
});

var manualFuelLightt = maketimer(0.4, FUEL.manualLight);
