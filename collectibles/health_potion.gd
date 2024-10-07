extends Collectible

@export var item: InvItem
	
func _on_pickable_area_body_entered(body: Node2D) -> void:
	# var health = body.get_node("Health")
	#health.health += 1
	if body is Player:
		body.collect(item)
		queue_free()
