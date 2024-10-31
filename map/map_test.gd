extends Node2D

var root_node: Branch
var tile_size: int = 16
var paths: Array = []
var room_list: Array[Room] = []
var map_width: int = 80
var map_height: int = 40

@onready var player_spawn = $PlayerSpawn
@onready var tile_map_layer = $TileMapLayer
@export var player: Player
@onready var map_element_layer = $MapElementLayer

func _ready():
	root_node = Branch.new(Vector2i(0, 0), Vector2i(map_width, map_height))
	for x in range(map_width):
		for y in range(map_height):
			BetterTerrain.set_cell(tile_map_layer, Vector2i(x, y), 0)
			BetterTerrain.update_terrain_cell(tile_map_layer, Vector2i(x, y))
	root_node._split(2, paths)
	queue_redraw()
	player_spawn.position = root_node.get_leaves()[0].get_center() * 16
	player.position = player_spawn.position
	pass
	
	
func is_inside_padding(x, y, leaf, padding):
	return x <= padding.x or y <= padding.y or x >= leaf.size.x - padding.z or y >= leaf.size.y - padding.w


func _draw():
	var rng = RandomNumberGenerator.new()
	var padding = Vector4i(
		rng.randi_range(2,3),
		rng.randi_range(2,3),
		rng.randi_range(2,3),
		rng.randi_range(2,3),
	)
	var room_type = 0
	for leaf in root_node.get_leaves():
		for x in range(leaf.size.x):
			for y in range(leaf.size.y):
				if not is_inside_padding(x, y, leaf, padding):
					BetterTerrain.set_cell(tile_map_layer, Vector2i(x + leaf.position.x, y + leaf.position.y), 1)
					BetterTerrain.update_terrain_cell(tile_map_layer, Vector2i(x + leaf.position.x, y + leaf.position.y))
		for path in paths:
			if path['left'].y == path['right'].y:
				# horizontal
				for i in range(path['right'].x - path['left'].x):
					BetterTerrain.set_cells(tile_map_layer, [Vector2i(path['left'].x + i, path['left'].y), Vector2i(path['left'].x + i, path['left'].y - 1)], 1)
					BetterTerrain.update_terrain_cells(tile_map_layer, [Vector2i(path['left'].x + i, path['left'].y), Vector2i(path['left'].x + i, path['left'].y - 1)])
			else:
				# vertical
				for i in range(path['right'].y - path['left'].y):
					BetterTerrain.set_cells(tile_map_layer, [Vector2i(path['left'].x, path['left'].y + i), Vector2i(path['left'].x - 1, path['left'].y + i)], 1)
					BetterTerrain.update_terrain_cells(tile_map_layer, [Vector2i(path['left'].x, path['left'].y + i), Vector2i(path['left'].x - 1, path['left'].y + i)])
		# room_list.push_back([Vector2i(leaf.position.x + padding.x, leaf.position.y + padding.y), Vector2i(leaf.size.x - padding.z, leaf.size.y - padding.w)])
		if room_type == 0 or room_type == 7:
			var room = Room.new(Vector2i(leaf.position.x + padding.x, leaf.position.y + padding.y), Vector2i(leaf.size.x - padding.z, leaf.size.y - padding.w), room_type)
			room_list.push_back(room)
		else:
			var room = Room.new(Vector2i(leaf.position.x + padding.x, leaf.position.y + padding.y), Vector2i(leaf.size.x - padding.z, leaf.size.y - padding.w), rng.randi_range(2,6))
			room_list.push_back(room)
			print(room.room_type)
		room_type = room_type + 1
	add_map_elements()
	pass


func add_map_elements():
	for room in room_list:
		# instantiate a label for the room name
		var label = Label.new()
		label.text = room.room_name
		label.position = Vector2i(room.coord.x * 16, room.coord.y * 16)
		add_child(label)
		var rng = RandomNumberGenerator.new()
		var spawn_position = Vector2i(room.coord.x + rng.randi_range(1,room.size.x - 4), room.coord.y + rng.randi_range(1,room.size.y - 4))
		map_element_layer.set_cell(spawn_position, 1, Vector2i(0, 0), 1)
