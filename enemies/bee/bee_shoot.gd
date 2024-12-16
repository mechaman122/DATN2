extends BeeState

@export var bullet_node : PackedScene 


func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	bee.attack_cooldown_timer.start()

func physics_update(delta: float) -> void:
	var dir = player.global_position - bee.global_position
	if dir.length() > 100:
		if bee.health.health == bee.health.max_health:
			finished.emit(FOLLOW)
		else:
			finished.emit(DASH)
	elif dir.length() <= 60:
		bee.velocity = -dir.normalized() * speed
	elif bee.health.health <= 0 :
		finished.emit(DEATH)


func _on_attack_cooldown_timer_timeout() -> void:
	shoot()

 
func shoot():
	var bullet = bullet_node.instantiate()
	var dir = player.global_position - bee.global_position
	bullet.position = bee.global_position
	bullet.direction = (player.global_position - bee.global_position).normalized()
	bullet.rotation = dir.normalized().angle()
	get_tree().current_scene.call_deferred("add_child",bullet)
