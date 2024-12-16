extends BeeState


func physics_update(delta: float) -> void:
	var dir = player.global_position - bee.global_position
	if dir.length() <= 100:
		bee.velocity = Vector2.ZERO
		finished.emit(SHOOT)
	elif dir.length() <= 60:
		bee.velocity = -dir.normalized() * speed
	elif bee.health.health <= 0 :
		finished.emit(DEATH)
	else:
		bee.velocity = dir.normalized() * speed