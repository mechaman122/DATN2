extends BatState

var player: CharacterBody2D

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	bat.health_changed = false
	bat.animation_player.play("hurt")
	bat.timer.start()

func physics_update(delta: float) -> void:
	bat.velocity = bat.knockback * 5
	bat.move_and_slide()
	bat.knockback = bat.knockback.lerp(Vector2.ZERO, 0.1)

	if bat.health.health <= 0:
		finished.emit(DIE)


func _on_timer_timeout() -> void:
	if bat.health.health <= 0:
		bat.timer.stop()
	else:
		finished.emit(CHASE1)
