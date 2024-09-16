extends Node2D

@onready var animated_sprite = $AnimatedSprite2D

func _on_hurtbox_area_entered(area):
	queue_free()


func _on_pickable_area_body_entered(body: Node2D) -> void:
	queue_free()
