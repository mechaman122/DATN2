extends PlayerState


func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player.velocity = Vector2()
	player.animation_player.play("idle")

	## move the sprite to the left a little bit
	player.move_and_slide()

func physics_update(delta: float) -> void:
	
	if player.health.health == 0:
		finished.emit(DIE)
	elif player.health_changed:
		finished.emit(HURT)
		player.health_changed = false
	elif SavedData.allow_input:
		if Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_down") or Input.is_action_pressed("move_up"):
			finished.emit(RUN)
		elif Input.is_action_pressed("ui_attack") and !player.has_weapon:
			finished.emit(MELEE)
		elif Input.is_action_just_pressed("move_roll"):
			finished.emit(ROLL)
