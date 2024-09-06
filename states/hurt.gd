extends PlayerState


func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player.animated_sprite.play("hurt")
	player.health.set_temp_immortality(1)
	
func physics_update(delta: float) -> void:
	player.velocity = player.knockback_direction * 500
	player.knockback_direction = Vector2()
	player.move_and_slide()

	if (player.animated_sprite.frame == player.animated_sprite.sprite_frames.get_frame_count("hurt") - 1):
		finished.emit(IDLE)
