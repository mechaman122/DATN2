extends Node2D

@onready var animated_sprite = $AnimatedSprite2D

func _on_hurtbox_area_entered(area):
	queue_free()
