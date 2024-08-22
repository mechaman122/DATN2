extends Node2D


func _on_hurtbox_area_entered(area):
	print(area)
	print(area.get_parent())
	# check if the parent of the area is the player
	if area.get_parent() is Player:
		# get the health component of the player
		var health = area.get_parent().get_node("Health")
		# increase the health of the player
		health.health += 1
		# remove the health potion from the scene
		queue_free()
