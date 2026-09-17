local LAPTOP = "eDP-1"
local HDMI = "HDMI-A-1"

-- Put it somewhere that already exists.
local state_file =
    os.getenv("HOME") .. "/.config/hypr/.presentation-mode"

local function read_mode()
    local f = io.open(state_file, "r")
    if not f then
        return "extend"
    end

    local mode = f:read("*l")
    f:close()

    if mode ~= "extend" and mode ~= "mirror" then
        return "extend"
    end

    return mode
end

local function write_mode(mode)
    local f = assert(io.open(state_file, "w"))
    f:write(mode)
    f:close()
end

local function apply_mode(mode)
    -- Laptop display
    hl.monitor({
        output = LAPTOP,
        mode = "preferred",
        position = "0x0",
        scale = 1.2,
        disabled = false,
    })

    if mode == "mirror" then
        hl.monitor({
            output = HDMI,
            mode = "preferred",
            position = "0x0",
            scale = 1,
            mirror = LAPTOP,
            disabled = false,
        })
    else -- extend
        hl.monitor({
            output = HDMI,
            mode = "preferred",
            position = "auto-right",
            scale = 1,
            disabled = false,
        })
    end
end

-- Restore persisted state whenever Hyprland config loads/reloads.
local presentation_mode = read_mode()
apply_mode(presentation_mode)

hl.bind("XF86Presentation", function()
    if presentation_mode == "extend" then
        presentation_mode = "mirror"
    else
        presentation_mode = "extend"
    end

    write_mode(presentation_mode)
    apply_mode(presentation_mode)

    hl.notification.create({
        text = "Display mode: " .. presentation_mode,
        timeout = 2000,
    })

    hl.dsp.exec_cmd(
        "notify-send -t 2000 'Display mode' '" .. presentation_mode .. "'"
    )
end)
