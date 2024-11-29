extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SoundManager.fade_in_bgm("bgm_1", 0.5)
	menu()


func _on_view_weapons_button_pressed() -> void:
	view_weapons()


func _on_options_button_pressed() -> void:
	options()


func _on_continue_button_pressed() -> void:
	continues()



func menu():
	$Menu.show()
	$Options.hide()
	$ViewWeapons.hide()
	$Continue.hide()
	$BackButton.hide()
	tween_pop($Menu)
	
func view_weapons():
	$Menu.hide()
	$Options.hide()
	$ViewWeapons.show()
	$Continue.hide()
	$BackButton.show()
	tween_pop($ViewWeapons)


func options():
	$Menu.hide()
	$Options.show()
	$ViewWeapons.hide()
	$Continue.hide()
	$BackButton.show()
	tween_pop($Options)


func continues():
	$Menu.hide()
	$Options.hide()
	$ViewWeapons.hide()
	$Continue.show()
	$BackButton.show()
	tween_pop($Continue)
	

func _on_back_button_pressed() -> void:
	menu()


func _on_start_button_pressed() -> void:
	SceneTransitor.start_transition_to("res://scenes/game.tscn")
	SoundManager.fade_out("bgm_1", 2)

func _on_exit_button_pressed() -> void:
	get_tree().quit()
	

func tween_pop(panel):
	SoundManager.play_sfx("confirm2_sfx")
	panel.scale = Vector2(0.85, 0.85)
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(panel, "scale", Vector2(1,1), 0.5)
	
