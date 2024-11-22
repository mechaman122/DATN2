extends Node


func display_number(value: int, position: Vector2, is_crit: bool = false):
	var number = Label.new()
	number.global_position = position
	number.text = str(abs(value))
	number.z_index = 5
	number.label_settings = LabelSettings.new()
	
	var color = "#FFF"
	if is_crit:
		color = "#B22"
	if value == 0:
		color = "#FFF8"
	if value < 0:
		color = "GREEN"
		
	number.label_settings.font_color = color
	number.label_settings.font_size = 8
	number.label_settings.outline_color = "#000"
	number.label_settings.outline_size = 1
	
	call_deferred("add_child", number)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		number, "position", Vector2(number.position.x + randi_range(-12, 12),number.position.y - 24), 0.25
	).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		number, "position:y", number.position.y, 0.3
	).set_ease(Tween.EASE_IN).set_delay(0.25)
	tween.tween_property(
		number, "scale", Vector2.ZERO, 0.25
	).set_ease(Tween.EASE_IN).set_delay(0.3)
	
	await(tween.finished)
	number.queue_free() 
