extends PlayerState


func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player.animation_player.play("hurt")
	if player.has_weapon:
		player.current_weapon.cancel_attack()
	player.health.set_temp_immortality(1)
	
func physics_update(delta: float) -> void:
	player.velocity = player.knockback_direction * 500
	player.knockback_direction = Vector2()
	player.move_and_slide()

	if player.animation_player.get_current_animation_position() == player.animation_player.get_current_animation_length():
		finished.emit(IDLE)
