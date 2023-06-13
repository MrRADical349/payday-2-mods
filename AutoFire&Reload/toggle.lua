if not AFR then
  return
end

local player = managers.player and managers.player:local_player()
local weapon = player and player:inventory():equipped_unit()
local id = weapon and weapon:base()._name_id

if not id then
  return
end

AFR[id] = not AFR[id] and true or nil

local message = string.format("Turned %s auto fire behaviour for %s.", AFR[id] and "off" or "on", managers.localization:text(tweak_data.weapon[id].name_id))
managers.chat:_receive_message(1, managers.localization:to_upper_text("menu_system_message"), message, tweak_data.system_chat_color)

local file = io.open(SavePath .. "afr.txt", "w+")
if file then
  file:write(json.encode(AFR))
  file:close()
end