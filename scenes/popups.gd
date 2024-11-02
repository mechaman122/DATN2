extends Control

func item_popup(slot: Rect2i, item: WeaponStats):
	if item != null:
		set_value(item)
		%ItemPopup.size = Vector2i.ZERO
	
	var mouse_pos = get_viewport().get_mouse_position()
	var correction
	var padding = 4
	
	if mouse_pos.x < get_viewport_rect().size.x/2:
		correction = Vector2i(slot.size.x + padding, 60)
	else:
		correction = -Vector2i(%ItemPopup.size.x + padding, 60)
	%ItemPopup.popup(Rect2i(slot.position + correction, %ItemPopup.size))

func item_hidepopup():
	%ItemPopup.hide()


func set_value(weapon_stats: WeaponStats) -> void:
		%Name.text = weapon_stats.weapon_name
		%Level.text = str(weapon_stats.level)
		%Damage.text = str(weapon_stats.damage)
		%Crit.text = str(weapon_stats.crit)
		%Rarity.text = set_text_effect(weapon_stats.rarity)


func set_text_effect(rarity : String):
	var text : String = rarity
	match rarity:
		"Rare":
			text = "[pulse freq=5.0 color=#ffffff40 ease=-2.0][color=blue]" + text + "[/color][/pulse]"
		"Epic":
			text = "[wave amp=15 freq=8][color=purple]" + text + "[/color][/wave]"
		"Legendary":
			text = "[tornado radius=2 freq=4][color=yellow]" + text + "[/color][/tornado]"
 
	return text
