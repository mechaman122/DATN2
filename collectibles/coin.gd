extends Collectible

func pre_interact(curr_interaction) -> void:
	if curr_interaction.get_parent() is Player:
		queue_free()
