extends Room
const TREASURE_SCENES:Dictionary = {
	"TREASURE": preload("res://map/map_elements/treasure.tscn")
}

func _ready() -> void:
	super._ready()
	var element = TREASURE_SCENES["TREASURE"].instantiate()
	element.position = coord * 16 + size * 8
	treasures_container.add_child(element)
