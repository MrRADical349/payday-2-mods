AFR = {}
local file = io.open(SavePath .. "afr.txt", "r")
if file then
  AFR = json.decode(file:read("*all"))
  file:close()
end

local _check_action_primary_attack_original = PlayerStandard._check_action_primary_attack
function PlayerStandard:_check_action_primary_attack(t, input, ...)
  if self._equipped_unit and not AFR[self._equipped_unit:base()._name_id] then
    if input.btn_primary_attack_state or input.btn_primary_attack_release then
      local action_forbidden = self:_is_reloading() or self:_changing_weapon() or self:_is_meleeing() or self._use_item_expire_t or self:_interacting() or self:_is_throwing_projectile() or self:_is_deploying_bipod() or self._menu_closed_fire_cooldown > 0 or self:is_switching_stances()
      if not action_forbidden then
        self._ext_inventory:equip_selected_primary(false)
        local weap_base = self._equipped_unit:base()
        local empty = weap_base.clip_empty and weap_base:clip_empty()
        local is_single = not tweak_data.weapon[weap_base._name_id].CAN_TOGGLE_FIREMODE and not table.contains(weap_base._blueprint, "wpn_fps_upg_i_singlefire")
        input.btn_primary_attack_press = not empty and is_single and input.btn_primary_attack_state or input.btn_primary_attack_press
        if empty and not weap_base:out_of_ammo() and not self:_is_using_bipod() then
          self._queue_reload_interupt = nil
          self:_start_action_reload_enter(t)
          return true
        end
      end
    end
  end
  return _check_action_primary_attack_original(self, t, input, ...)
end