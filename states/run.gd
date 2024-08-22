extends PlayerState

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player.animated_sprite.play("run")

func physics_update(delta: float) -> void:
	# move in 4 directions
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = player.speed * input_direction_x
	var input_direction_y := Input.get_axis("move_up", "move_down")
	player.velocity.y = player.speed * input_direction_y

	# flip sprite
	if input_direction_x != 0:
		player.animated_sprite.flip_h = input_direction_x < 0
	# move the sprite to the left a little bit
	if input_direction_x < 0:
		player.animated_sprite.offset.x = -4
	elif input_direction_x > 0:
		player.animated_sprite.offset.x = 0

	player.move_and_slide()

	if player.health.health == 0:
		finished.emit(DIE)
	elif not Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_up"):
		finished.emit(IDLE)
	elif Input.is_action_pressed("melee"):
		finished.emit(MELEE)