extends Control

const dot_green = preload("res://assets/sprites/rpg_icon/Individual icons (16x16)/dot_green.png")
const dot_red = preload("res://assets/sprites/rpg_icon/Individual icons (16x16)/dot_red.png")

func item_popup(slot: Rect2i, item: Item):
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


func set_value(item_stats: Item) -> void:
	%ItemTexture.texture = item_stats.texture
	%Name.text = item_stats.item_name
	%Rarity.text = set_text_effect(item_stats.rarity)
	%Description.text = str(item_stats.description)
	
	if item_stats is WeaponStats:
		%Damage.text = str(item_stats.stats["damage"])
		%Crit.text = str(item_stats.stats["crit"])
		
		%ItemPopup.get_node("VBoxContainer/HBoxContainer2").show()
		%ItemPopup.get_node("VBoxContainer/HBoxContainer3").show()
		%ItemPopup.get_node("VBoxContainer/HBoxContainer4").hide()
		#%ItemPopup.get_node("VBoxContainer/HBoxContainer5").hide()
		
	elif item_stats is ArmorStats:
		%Armor.text = str(item_stats.stats["armor"])
		#var string = str(item_stats.bonus_attribute)
		#%BonusLabel.text = string[0].to_upper() + string.substr(1, -1)
		#%BonusAttributeValue.text = str(item_stats.bonus_attribute_value)
		
		%ItemPopup.get_node("VBoxContainer/HBoxContainer2").hide()
		%ItemPopup.get_node("VBoxContainer/HBoxContainer3").hide()
		%ItemPopup.get_node("VBoxContainer/HBoxContainer4").show()
		#%ItemPopup.get_node("VBoxContainer/HBoxContainer5").show()

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
