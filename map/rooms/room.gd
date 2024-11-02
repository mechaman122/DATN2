extends Node
class_name Room


@export_enum("starting", "shop", "treasure", "enemy", "temple", "well", "trade", "ending")
var room_type: String
@onready var tile_map_layer: TileMapLayer = get_node("TileMapLayer")
@onready var treasures_container: Node2D = get_node("Treasures")
@onready var traps_container: Node2D = get_node("Traps")
@onready var label: Label = get_node("Label")

const my_scene: PackedScene = preload("res://map/rooms/room.tscn")

var coord: Vector2i = Vector2i.ZERO
var size: Vector2i = Vector2i.ZERO

const ELEMENT_SCENES: Dictionary = {
	"TRAP_FLOOR": preload("res://map/map_elements/trap_floor.tscn"),
	"TREASURE": preload("res://map/map_elements/treasure.tscn")
}
const ENEMY_SCENES: Dictionary = {}

var element_num: int = 2

static func new_room(coord: Vector2i, size: Vector2i, room_type: String) -> Room:
	var new_room: Room = load("res://map/rooms/" + room_type + "_room.tscn").instantiate()
	new_room.coord = coord
	new_room.size = size
	new_room.room_type = room_type
	return new_room


func _ready() -> void:
	_spawn_elements()
	label.text = room_type
	label.position = coord * 16 + size * 8

func _spawn_elements() -> void:
	for i in range(element_num):
		var element_type = ELEMENT_SCENES.keys()[randi() % ELEMENT_SCENES.size()]
		var element = ELEMENT_SCENES[element_type].instantiate()
		element.position = Vector2i((coord.x + randi_range(3,size.x - 4)) * 16 + 8, (coord.y + randi_range(3,size.y - 4)) * 16 + 8)
		if element_type == "TRAP_FLOOR":
			traps_container.add_child(element)
		elif element_type == "TREASURE":
			treasures_container.add_child(element)
		else:
			print("Element type not found")
	pass
