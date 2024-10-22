extends PlayerState

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player.animation_player.play("run")

func physics_update(delta: float) -> void:
	# move in 4 directions
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = player.speed * input_direction_x
	var input_direction_y := Input.get_axis("move_up", "move_down")
	player.velocity.y = player.speed * input_direction_y

	player.move_and_slide()

	if player.health.health == 0:
		finished.emit(DIE)
	elif player.health_changed:
		finished.emit(HURT)
		player.health_changed = false
	elif Input.is_action_just_pressed("move_roll"):
		finished.emit(ROLL)
	elif Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_down") or Input.is_action_pressed("move_up"):
		finished.emit(RUN)
	elif not Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_up"):
		finished.emit(IDLE)
	elif Input.is_action_pressed("ui_attack") and !player.has_weapon:
		finished.emit(MELEE)
