extends PlayerState


# Called when the node enters the scene tree for the first time.
func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	# play the die animation only once
	if player.has_weapon:
		player.current_weapon.cancel_attack()
	player.animation_player.play("die")
	SoundManager.play_sfx("player_die_sfx")
	# queue_free()
