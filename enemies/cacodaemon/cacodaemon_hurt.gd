extends CacodaemonState

var player: CharacterBody2D

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	cacodaemon.health_changed = false
	cacodaemon.animation_player.play("hurt")
	cacodaemon.timer.start()

func physics_update(delta: float) -> void:
	cacodaemon.velocity = cacodaemon.knockback * 5
	cacodaemon.move_and_slide()
	cacodaemon.knockback = cacodaemon.knockback.lerp(Vector2.ZERO, 0.1)

	if cacodaemon.health.health <= 0:
		finished.emit(DIE)


func _on_timer_timeout() -> void:
	if cacodaemon.health.health <= 0:
		cacodaemon.timer.stop()
	else:
		finished.emit(CHASE)
