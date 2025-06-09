local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local battery = sbar.add("item", "widgets.battery", {
  position = "right",
  icon = {
    font = {
      style = settings.font.style_map["Regular"],
      size = 19.0,
    }
  },
  label = { font = { family = settings.font.numbers } },
  update_freq = 180,
  popup = { align = "center" }
})

local remaining_time = sbar.add("item", {
  position = "popup." .. battery.name,
  icon = {
    string = "Time remaining:",
    width = 100,
    align = "left"
  },
  label = {
    string = "??:??h",
    width = 100,
    align = "right"
  },
})


battery:subscribe({"routine", "power_source_change", "system_woke"}, function()
  local handle = io.popen("pmset -g batt | grep -o '[0-9]*%' | cut -d'%' -f1")
  local charge = tonumber(handle:read("*a"))
  handle:close()
  
  local icon = "!"
  local label = charge .. "%"

  local color = colors.mauve

  local handle = io.popen("pmset -g batt | grep -Eo 'AC Power'")
  local output = handle:read("*a")
  local charging = output:match("AC Power") ~= nil
  handle:close()

  if charging then
    icon = icons.battery.charging
  else
    if charge > 80 then
      icon = icons.battery._100
    elseif charge > 60 then
      icon = icons.battery._75
    elseif charge > 40 then
      icon = icons.battery._50
    elseif charge > 20 then
      icon = icons.battery._25
      color = colors.maroon
    else
      icon = icons.battery._0
      color = colors.blue
    end
  end

  local lead = ""
  if charge < 10 then
    lead = "0"
  end

  battery:set({
    icon = {
      string = icon,
      color = color
    },
    label = { string = lead .. label },
  })
end)

sbar.add("bracket", "widgets.battery.bracket", { battery.name }, {
  background = { color = colors.bg1 }
})

sbar.add("item", "widgets.battery.padding", {
  position = "right",
  width = settings.group_paddings
})
