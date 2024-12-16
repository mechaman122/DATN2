extends UndeadBossState


func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	undead.animation_player.play("idle")

func physics_update(delta: float) -> void:
	var dir = player.global_position - undead.global_position
	if dir.x < 0:
		undead.animated_sprite.flip_h = true
	else:
		undead.animated_sprite.flip_h = false
	undead.velocity = dir.normalized() * speed
	
	if dir.length() < 40:
		undead.velocity = Vector2.ZERO
		finished.emit(ATK)
	if dir.length() > 150:
		var chance = randi() % 2
		match chance:
			0:
				undead.velocity = Vector2.ZERO
				finished.emit(SPAWN)
			1:
				undead.velocity = Vector2.ZERO
				finished.emit(TELE)
	
	if undead.health.health <= 0:
		finished.emit(DEATH)
