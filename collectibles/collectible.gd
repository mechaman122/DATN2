extends Node2D

class_name Collectible


func _on_pickable_area_body_entered(body: Node2D) -> void:
	if body is Player:
		use()
		queue_free()
		
func use():
	pass
