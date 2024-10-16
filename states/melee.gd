extends PlayerState
var melee_type = 2

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	if !player.has_weapon:
		var mouse_direction = player.get_mouse_direction()
		# turn the hitbox to the direction of the mouse
		if mouse_direction.x > 0:
			player.melee_hitbox.position = Vector2(11, -8)
		else:
			player.melee_hitbox.position = Vector2(-11, -8)
		melee_type = (melee_type + 1) % 2
		var mt = melee_type + 1
		player.animation_player.play("melee_" + str(mt))

func physics_update(delta: float) -> void:
	# transition to other state after animation finishes
	if player.health.health == 0:
		finished.emit(DIE)
	if player.animation_player.get_current_animation_position() == player.animation_player.get_current_animation_length():
		# player.animated_sprite.sprite_frames.get_frame_count("melee_2") - 1)
		finished.emit(IDLE)
	elif Input.is_action_just_pressed("ui_attack") and !player.has_weapon:
		finished.emit(MELEE)
	elif Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_down") or Input.is_action_pressed("move_up"):
		finished.emit(RUN)
	else:
		finished.emit(IDLE)
	

func _on_melee_hitbox_area_entered(hurtbox: Hurtbox) -> void:
	print(hurtbox)
