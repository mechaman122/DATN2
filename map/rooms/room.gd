extends Node
class_name Room

@export var room_name: String = ""
@export var room_type: int

enum {STARTING, SHOP, TREASURE, ENEMY, TEMP, TEMP1, TEMP2, ENDING}

var coord: Vector2i = Vector2i.ZERO
var size: Vector2i = Vector2i.ZERO

var elements: Dictionary = {}
var enemies: Dictionary = {}

func _init(coord, size, type) -> void:
	self.coord = coord
	self.size = size
	self.room_type = type
	assign_room_name()

func assign_room_name() -> void:
	match room_type:
		STARTING:
			room_name = "Starting Room"
		SHOP:
			room_name = "Shop Room"
		TREASURE:
			room_name = "Treasure Room"
		ENEMY:
			room_name = "Enemy Room"
		TEMP:
			room_name = "Temp Room"
		TEMP1:
			room_name = "Temp Room 1"
		TEMP2:
			room_name = "Temp Room 2"
		ENDING:
			room_name = "Ending Room"