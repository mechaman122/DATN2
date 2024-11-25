extends Panel

var paused = false
var save_file_path = "user://save/"

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_pause"):
		pause()


func pause():
	if paused:
		hide()
		get_tree().paused = false
		#Engine.time_scale = lerp(0, 1, 1)
	else:
		show()
		#Engine.time_scale = 0
		get_tree().paused = true
	
	paused = !paused


func _on_resume_pressed() -> void:
	hide()
	get_tree().paused = false
	paused = false


func _on_quit_pressed() -> void:
	paused = false
	get_tree().paused = false
	
	var data_to_save = SavedData.save_data()
	ResourceSaver.save(data_to_save, save_file_path + str(Time.get_unix_time_from_datetime_string(data_to_save.created_date)) + ".tres")
	
	var main_menu_path = "res://scenes/main_menu.tscn"
	SceneTransitor.start_transition_to(main_menu_path)
