extends Room
const ENEMY_SCENES:Dictionary = {
	"BAT": preload("res://enemies/bat/bat.tscn"),
	#"GLADIATOR": preload("res://enemies/gladiator/gladiator.tscn"),
}
const BOX_SCENE = preload("res://map/map_elements/box.tscn")

func _ready() -> void:
	super._ready()
	for i in range(1):
		var enemy_type = ENEMY_SCENES.keys()[randi() % ENEMY_SCENES.size()]
		var enemy = ENEMY_SCENES[enemy_type].instantiate()
		enemy.position = Vector2i((coord.x + randi_range(3,size.x - 4)) * 16 + 8, (coord.y + randi_range(3,size.y - 4)) * 16 + 8)
		enemy.set_init_pos(enemy.position, label.position, size * 16)
		enemy_container.add_child(enemy)
		EventBus.emit_signal("enemy_spawn")
	#EventBus.enemy_spawn.connect(_on_enemy_spawn)
	_spawn_elements()

func _spawn_elements() -> void:
	for i in range(4):
		var element = BOX_SCENE.instantiate()
		element.position = Vector2i((coord.x + randi_range(3,size.x - 4)) * 16 + 8, (coord.y + randi_range(3,size.y - 4)) * 16 + 8)
		destructible_container.add_child(element)
