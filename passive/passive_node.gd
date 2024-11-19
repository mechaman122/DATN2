extends Node2D

@export var passive: Resource

func _ready() -> void:
	var p = passive.new(owner, passive.value)
