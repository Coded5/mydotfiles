hl.config({
    xwayland = {
        force_zero_scaling = true
    }
})

hl.monitor({
	output = "eDP-1",
	mode = "2880x1800@60",
	position = "0x0",
	scale = "1.2",
})

hl.device({
    name = "pixa3835:00-093a:3835-touchpad",
    sensitivity = 0.2
})
