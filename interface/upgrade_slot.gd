extends TextureButton

@export var weapon: Weapon2:
	set(value):
		weapon = value
		
		texture_normal = value.stats.texture
		$Label.text = "Lvl " + str(value.stats.level + 1)
		$Description.text = value.stats.upgrades[value.stats.level - 1].description


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and weapon:
		print(weapon.stats.item_name)
		weapon.upgrade_weapon()
		get_parent().close_option()
