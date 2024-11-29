extends Node2D

class_name Collectible

@export var effects: Array[StatusEffect] = []


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		active_effect(body)
		queue_free()
		

func active_effect(body: Node2D):
	for effect in effects:
		body.apply_status_effect(effect)
