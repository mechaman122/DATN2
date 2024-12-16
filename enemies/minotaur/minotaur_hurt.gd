extends MinotaurState

var player: CharacterBody2D

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	minotaur.health_changed = false
	minotaur.animation_player.play("hurt")
	minotaur.health_changed = false

func physics_update(delta: float) -> void:
	var dir = player.global_position - minotaur.global_position
	#minotaur.velocity = minotaur.knockback * 5
	#minotaur.move_and_slide()
	#minotaur.knockback = minotaur.knockback.lerp(Vector2.ZERO, 0.1)
	if dir.length() > 0:
		finished.emit(CHASE)
	if minotaur.health.health <= 0:
		finished.emit(DIE)

#
#func _on_hurt_timer_timeout() -> void:
	#if gladiator.health.health <= 0:
		#gladiator.hurt_timer.stop()
	#else:
		#finished.emit(CHASE)
