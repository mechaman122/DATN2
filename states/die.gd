extends PlayerState


# Called when the node enters the scene tree for the first time.
func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	# play the die animation only once
	player.animated_sprite.play("die")
	# queue_free()
