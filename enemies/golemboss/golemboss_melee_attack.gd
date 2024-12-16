extends GolemBossState

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	golemboss.animation_player.play("melee_attack")
	
func physics_update(delta: float) -> void:
	var dir = player.position - golemboss.position

	if dir.x < 0:
		golemboss.hitbox.position = Vector2(-29, 10)
		golemboss.sprite.flip_h = true
	elif dir.x > 0:
		golemboss.hitbox.position = Vector2(29, 10)
		golemboss.sprite.flip_h = false
	
	if dir.length() > 30:
		finished.emit(FOLLOW)
	elif golemboss.health.health <= 0:
		finished.emit(DEATH)
