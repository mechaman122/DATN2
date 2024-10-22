extends Node2D

var root_node: Branch
var tile_size: int = 16
var paths: Array = []
var map_width: int = 80
var map_height: int = 40

@onready var player_spawn = $PlayerSpawn
@onready var tile_map_layer = $TileMapLayer
@onready var player = $Adventurer

func _ready():
	root_node = Branch.new(Vector2i(0, 0), Vector2i(map_width, map_height))
	for x in range(map_width):
		for y in range(map_height):
			BetterTerrain.set_cell(tile_map_layer, Vector2i(x, y), 0)
			BetterTerrain.update_terrain_cell(tile_map_layer, Vector2i(x, y))
	root_node._split(2, paths)
	queue_redraw()
	player_spawn.position = paths[0]['left']
	#player.position = player_spawn.position
	print(player.position)
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
	
	for leaf in root_node.get_leaves():
		draw_rect(
			Rect2i(
				leaf.position.x * tile_size, #x
				leaf.position.y * tile_size, #y
				leaf.size.x * tile_size, #width
				leaf.size.y * tile_size, #height
			),
			Color.GREEN, #color
			false # is_filled
		)
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
	pass
