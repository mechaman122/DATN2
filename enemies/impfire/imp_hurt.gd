extends ImpState

var player: CharacterBody2D

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	imp.health_changed = false
	imp.animation_player.play("hurt")
	imp.hurt.start()

func physics_update(delta: float) -> void:
	imp.velocity = imp.knockback * 5
	imp.move_and_slide()
	imp.knockback = imp.knockback.lerp(Vector2.ZERO, 0.1)

	if imp.health.health <= 0:
		finished.emit(DIE)

func _on_hurt_timer_timeout() -> void:
	if imp.health.health <= 0:
		imp.hurt.stop()
	else:
		finished.emit(CHASE)
