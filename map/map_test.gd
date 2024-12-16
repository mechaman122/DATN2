extends Node2D
class_name MapTest

var root_node: Branch
var tile_size: int = 16
var paths: Array = []
var room_list: Array[Room] = []
var map_width: int = 80
var map_height: int = 40
var theme = 0
var enemy_num = 0
const DUNGEON_THEME = [
	"res://assets/sprites/map/dungeon_spritesheet.png",
	"res://assets/sprites/map/ice_spritesheet.png",
	"res://assets/sprites/map/lava_spritesheet.png",
]
const LAVA_SCENE = preload("res://map/map_elements/magma_floor.tscn")
@onready var player_spawn = $PlayerSpawn
@onready var tile_map_layer = $TileMapLayer
@export var player: Player
@onready var map_element_layer = $MapElementLayer

const ROOM_TYPE = ["starting", "shop", "treasure", "enemy", "enemy", "enemy", "enemy", "ending"]
const SPAWN_RATE = [0, 0.1, 0.1, 0.5, 0.1, 0.1, 0.1, 0]

func _ready():
	EventBus.floor_changed.connect(change_theme)
	EventBus.enemy_spawn.connect(_on_enemy_spawn)
	EventBus.enemy_died.connect(_on_enemy_died)
	root_node = Branch.new(Vector2i(0, 0), Vector2i(map_width, map_height))
	for x in range(map_width):
		for y in range(map_height):
			BetterTerrain.set_cell(tile_map_layer, Vector2i(x, y), 0)
			BetterTerrain.update_terrain_cell(tile_map_layer, Vector2i(x, y))
	root_node._split(2, paths)
	queue_redraw()
	player_spawn.position = root_node.get_leaves()[0].get_center() * 16
	player.position = player_spawn.position
	if theme == 2:
		for i in range(20):
			var lava = LAVA_SCENE.instantiate()
			lava.position = Vector2i((0 + randi_range(3,80 - 4)) * 16 + 8, (0 + randi_range(3,40 - 4)) * 16 + 8)
		$SpawnTimer.start()
	else:
		$SpawnTimer.stop()
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
		var room_coord = Vector2i(leaf.position.x + padding.x, leaf.position.y + padding.y)
		var room_size = Vector2i(leaf.size.x - padding.z, leaf.size.y - padding.w)
		var room
		if room_type == 0 or room_type == 7:
			room = Room.new_room(room_coord, room_size, ROOM_TYPE[room_type])
		else:
			var room_type_to_spawn = weightedRandomChoice(ROOM_TYPE, SPAWN_RATE)
			room = Room.new_room(room_coord, room_size, room_type_to_spawn)
		add_child(room)
		move_child(room, -2)
		room_type = room_type + 1
	pass

func weightedRandomChoice(choices, weights):
	var table = []
	for i in range(choices.size()):
		for j in range(weights[i] * 100):
			table.append(i)
	return choices[table[randi() % table.size()]]

func change_theme():
	if (SavedData.level - 1) % 5 == 0 && SavedData.level != 1:
		theme = ((SavedData.level - 1 ) / 5 )%(DUNGEON_THEME.size())
		var texture = load(DUNGEON_THEME[theme])
		tile_map_layer.tile_set.get_source(1).texture = texture
		tile_map_layer.tile_set.get_source(0).texture = texture

func _on_enemy_spawn():
	enemy_num += 1
func _on_enemy_died(source):
	enemy_num -= 1
	if enemy_num <= 0 :
		EventBus.emit_signal("all_enemy_defeated")


func _on_spawn_timer_timeout() -> void:
	for i in range(20):
			var lava = LAVA_SCENE.instantiate()
			lava.position = Vector2i((0 + randi_range(3,80 - 4)) * 16 + 8, (0 + randi_range(3,40 - 4)) * 16 + 8)
			
