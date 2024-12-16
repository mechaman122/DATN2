extends GolemBossState

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	golemboss.animation_player.play("idle")

func physics_update(delta: float) -> void:
	var dir = player.global_position - golemboss.global_position
	if dir.x < 0:
		golemboss.sprite.flip_h = true
	else:
		golemboss.sprite.flip_h = false
	golemboss.velocity = dir.normalized() * speed
	
	if dir.length() < 30:
		golemboss.velocity = Vector2.ZERO
		finished.emit(MELEE)
	elif dir.length() > 130:
		var chance = randi() % 2
		match chance:
			0:
				golemboss.velocity = Vector2.ZERO
				finished.emit(HOMING)
			1:
				golemboss.velocity = Vector2.ZERO
				finished.emit(LASER)
	if golemboss.armorbuff:
		golemboss.armorbuff = false
		finished.emit(ARMOR)
	if golemboss.health.health <= 0:
		finished.emit(DEATH)
