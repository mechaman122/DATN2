extends PlayerState


func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player.velocity = Vector2()
	player.animated_sprite.play("idle")

	# move the sprite to the left a little bit
	if player.animated_sprite.flip_h == true:
		player.animated_sprite.offset.x = -4
	else:
		player.animated_sprite.offset.x = 0
	player.move_and_slide()

func physics_update(delta: float) -> void:

	# flip sprite based on mouse position
	if player.get_global_mouse_position().x < player.global_position.x:
		player.animated_sprite.flip_h = true
	else:
		player.animated_sprite.flip_h = false
	# move the sprite to the left a little bit
	if player.animated_sprite.flip_h == true:
		player.animated_sprite.offset.x = -4
	else:
		player.animated_sprite.offset.x = 0
	
	if player.health.health == 0:
		finished.emit(DIE)
	elif player.health_changed:
		finished.emit(HURT)
		player.health_changed = false
	elif Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_down") or Input.is_action_pressed("move_up"):
		finished.emit(RUN)
	elif Input.is_action_pressed("melee"):
		finished.emit(MELEE)
