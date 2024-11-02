extends Room

class_name starting_room

func _spawn_elements() -> void:
	var element = ELEMENT_SCENES["TREASURE"].instantiate()
	element.position = Vector2i((coord.x + randi_range(3,size.x - 4)) * 16 + 8, (coord.y + randi_range(3,size.y - 4)) * 16 + 8)
	treasures_container.add_child(element)
	pass
