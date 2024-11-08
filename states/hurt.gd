extends PlayerState

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player.animation_player.play("hurt")
	player.health_changed = false
	if player.has_weapon:
		player.current_weapon.cancel_attack()
	player.health.set_temp_immortality(1)
	
func physics_update(delta: float) -> void:
	player.velocity = player.knockback * 10
	player.move_and_slide()
	player.knockback = player.knockback.lerp(Vector2.ZERO, 0.1)

	if player.animation_player.get_current_animation_position() == player.animation_player.get_current_animation_length():
		finished.emit(IDLE)
