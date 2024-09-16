extends Node2D


func _on_pickable_area_body_entered(body: Node2D) -> void:
	var health = body.get_node("Health")
	health.health += 1
	queue_free()
