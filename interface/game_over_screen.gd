extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.player_died.connect(_on_player_died)
	%Label.text = "[pulse freq=1.0 color=#ffffff40 ease=-2.0]" + %Label.text + "[/pulse]"
	self.hide()


func _input(event: InputEvent) -> void:
	if self.modulate.a == 1 and self.visible == true:
		if event is InputEventKey and event.pressed:
			await get_tree().create_timer(1).timeout
			SceneTransitor.start_transition_to("res://scenes/main_menu.tscn")
			if SavedData.save_data_name == "":
				return
			DirAccess.remove_absolute("user://save/" + SavedData.save_data_name)
			SoundManager.stop_all()
			SavedData.allow_input = true

func _on_player_died():
	await get_tree().create_timer(2).timeout
	self.show()
	self.modulate = Color(1,1,1,0)
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "modulate", Color(1,1,1,1), 0.8)
	SoundManager.play_mfx("game_over_music")
