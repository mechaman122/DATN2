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
	if SavedData.can_quit_without_losing_save == false:
		%ConfirmationDialog.dialog_text = "The progress will not be saved!
		
		You have not advanced to the next floor"
	else:
		%ConfirmationDialog.dialog_text = "The progress will be saved!"
	%ConfirmationDialog.visible = true

func _on_confirmation_dialog_confirmed() -> void:
	paused = false
	get_tree().paused = false
	if SavedData.can_quit_without_losing_save == true:
		var data_to_save = SavedData.save_data()
		if SavedData.save_data_name == "":
			ResourceSaver.save(data_to_save, save_file_path + str(Time.get_unix_time_from_datetime_string(data_to_save.created_date)) + ".tres")
		else:
			ResourceSaver.save(data_to_save, save_file_path + SavedData.save_data_name)
	else:
		DirAccess.remove_absolute("user://save/" + SavedData.save_data_name)
		SavedData.save_data_name = ""
	var main_menu_path = "res://scenes/main_menu.tscn"
	SceneTransitor.start_transition_to(main_menu_path)
