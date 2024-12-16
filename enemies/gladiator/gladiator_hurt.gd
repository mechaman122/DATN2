extends GladiatorState

var player: CharacterBody2D

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	gladiator.health_changed = false
	gladiator.animation_player.play("hurt")
	gladiator.hurt_timer.start()

func physics_update(delta: float) -> void:
	gladiator.velocity = gladiator.knockback * 5
	gladiator.move_and_slide()
	gladiator.knockback = gladiator.knockback.lerp(Vector2.ZERO, 0.1)

	if gladiator.health.health <= 0:
		finished.emit(DIE)


func _on_hurt_timer_timeout() -> void:
	if gladiator.health.health <= 0:
		gladiator.hurt_timer.stop()
	else:
		finished.emit(CHASE)
