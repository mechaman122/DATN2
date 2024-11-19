extends Collectible
	
func pre_interact(curr_interaction) -> void:
	if curr_interaction.get_parent() is Player:
		var health = curr_interaction.get_parent().get_node("Health")
		health.health += 1
		curr_interaction.get_parent().get_node("EffectPlayer").play("heal")
		queue_free()
