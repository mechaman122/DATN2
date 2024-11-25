extends TabBar


func _on_master_value_changed(value: float) -> void:
	set_volume(0, value)


func set_volume(idx, value):
	AudioServer.set_bus_volume_db(idx, linear_to_db(value))
	

func _on_check_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0, toggled_on)
