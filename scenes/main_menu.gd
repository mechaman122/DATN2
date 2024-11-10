extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu()


func _on_view_weapons_button_pressed() -> void:
	view_weapons()


func _on_options_button_pressed() -> void:
	options()


func menu():
	$Menu.show()
	$Options.hide()
	$ViewWeapons.hide()
	$BackButton.hide()
	tween_pop($Menu)
	
func view_weapons():
	$Menu.hide()
	$Options.hide()
	$ViewWeapons.show()
	$BackButton.show()
	tween_pop($ViewWeapons)


func options():
	$Menu.hide()
	$Options.show()
	$ViewWeapons.hide()
	$BackButton.show()
	tween_pop($Options)


func _on_back_button_pressed() -> void:
	menu()


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func tween_pop(panel):
	SoundManager.play_sfx("res://assets/sounds/Confirm_tones/style2/confirm_style_2_001.wav")
	panel.scale = Vector2(0.85, 0.85)
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(panel, "scale", Vector2(1,1), 0.5)
	
