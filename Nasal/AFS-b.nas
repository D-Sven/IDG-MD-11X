# McDonnell Douglas MD-11 FMA System
# Joshua Davidson (it0uchpods/411)

#########################################
# Copyright (c) it0uchpods Design Group #
#########################################

# Master Lateral
setlistener("/it-autoflight/mode/lat", func {
	var lat = getprop("/it-autoflight/mode/lat");
	if (lat == "HDG") {
		setprop("/modes/pfd/fma/roll-mode", "HEADING     ");
	} else if (lat == "LNAV") {
		setprop("/modes/pfd/fma/roll-mode", "NAV1");
	} else if (lat == "LOC") {
		setprop("/modes/pfd/fma/roll-mode", "LOC");
	} else if (lat == "ALGN") {
		setprop("/modes/pfd/fma/roll-mode", "ALIGN");
	} else if (lat == "T/O") {
		setprop("/modes/pfd/fma/roll-mode", "TAKEOFF");
	} else if (lat == "RLOU") {
		setprop("/modes/pfd/fma/roll-mode", "ROLLOUT");
	}
});

# Master Vertical
setlistener("/it-autoflight/mode/vert", func {
	var vert = getprop("/it-autoflight/mode/vert");
	if (vert == "ALT HLD") {
		setprop("/modes/pfd/fma/pitch-mode", "HOLD");
	} else if (vert == "ALT CAP") {
		setprop("/modes/pfd/fma/pitch-mode", "HOLD");
	} else if (vert == "V/S") {
		setprop("/modes/pfd/fma/pitch-mode", "V/S");
	} else if (vert == "G/S") {
		setprop("/modes/pfd/fma/pitch-mode", "G/S");
	} else if (vert == "SPD CLB") {
		setprop("/modes/pfd/fma/pitch-mode", "CLB THRUST");
	} else if (vert == "SPD DES") {
		setprop("/modes/pfd/fma/pitch-mode", "IDLE CLAMP");
	} else if (vert == "FPA") {
		setprop("/modes/pfd/fma/pitch-mode", "FPA");
	} else if (vert == "LAND") {
		setprop("/modes/pfd/fma/pitch-mode", "G/S");
	} else if (vert == "FLARE") {
		setprop("/modes/pfd/fma/pitch-mode", "FLARE");
	} else if (vert == "T/O CLB") {
		setprop("/modes/pfd/fma/pitch-mode", "T/O CLAMP");
	} else if (vert == "G/A CLB") {
		setprop("/modes/pfd/fma/pitch-mode", "G/A THRUST");
	} else if (vert == "ROLLOUT") {
		setprop("/modes/pfd/fma/pitch-mode", "ROLLOUT");
	}
});

# Arm LOC
setlistener("/it-autoflight/output/loc-armed", func {
	var loca = getprop("/it-autoflight/output/loc-armed");
	if (loca) {
		setprop("/modes/pfd/fma/roll-mode-armed", "LAND ARMED");
	} else {
		setprop("/modes/pfd/fma/roll-mode-armed", "");
	}
	appr_arm();
});

# Arm G/S
setlistener("/it-autoflight/output/appr-armed", func {
	appr_arm();
});

var appr_arm = func {
	var loca = getprop("/it-autoflight/output/loc-armed");
	var appa = getprop("/it-autoflight/output/appr-armed");
	if (appa and !loca) {
		setprop("/modes/pfd/fma/pitch-mode-armed", "LAND ARMED");
	} else {
		setprop("/modes/pfd/fma/pitch-mode-armed", "");
	}
}

# AP
var ap = func {
	var ap1 = getprop("/it-autoflight/output/ap1");
	var ap2 = getprop("/it-autoflight/output/ap2");
	if (ap1 and ap2) {
		setprop("/modes/pfd/fma/ap-mode", "AP1");
	} else if (ap1 and !ap2) {
		setprop("/modes/pfd/fma/ap-mode", "AP1");
	} else if (ap2 and !ap1) {
		setprop("/modes/pfd/fma/ap-mode", "AP2");
	} else if (!ap1 and !ap2) {
		setprop("/modes/pfd/fma/ap-mode", "");
	}
}

setlistener("/it-autoflight/output/ap1", func {
	ap();
});
setlistener("/it-autoflight/output/ap2", func {
	ap();
});
