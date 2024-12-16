#extends Room

#func _ready() -> void:
	#super._ready()
	#$Statirs.position = Vector2i((coord.x) * 16 + 8, (coord.y) * 16 + 8)
