extends PlayerState

# Called when the node enters the scene tree for the first time.
func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player.health.set_temp_immortality(0.8)
	player.animation_player.play("roll")
	
func physics_update(delta: float) -> void:
	# while player.animation_player.is_playing():
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = player.speed *  input_direction_x * 1.2
	var input_direction_y := Input.get_axis("move_up", "move_down")
	player.velocity.y = player.speed * input_direction_y * 1.2
	player.move_and_slide()

	if player.animation_player.get_current_animation_position() == player.animation_player.get_current_animation_length():
		finished.emit(IDLE)
