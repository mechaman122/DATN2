extends PlayerState
var melee_type = 2

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
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
		
	melee_type = (melee_type + 1) % 2
	var mt = melee_type + 1
	player.animated_sprite.play("melee_" + str(mt))

func physics_update(delta: float) -> void:
	# transition to other state after animation finishes
	if player.health.health == 0:
		finished.emit(DIE)
	elif (player.animated_sprite.frame == player.animated_sprite.sprite_frames.get_frame_count("melee_2") - 1):
		finished.emit(IDLE)
	# if spamming attack, wait before transitioning to other state
	elif Input.is_action_just_pressed("melee"):
		finished.emit(MELEE)
	# elif Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_down") or Input.is_action_pressed("move_up"):
	# 		await get_tree().create_timer(0.15).timeout
	# 		finished.emit(RUN)
