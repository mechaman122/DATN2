extends ImpState

@export var speed := 40.0
var player: CharacterBody2D
var knockback_direction = Vector2()
var fliph = false
const FIRE_SCENE: PackedScene = preload("res://enemies/impfire/fire.tscn")
@export var projectile_speed: int = 150

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	var dir = player.global_position - imp.global_position
	var projectile: Node2D = FIRE_SCENE.instantiate()
	print(imp.global_position)
	projectile.launch(imp.global_position + Vector2(-5 , -10), dir.normalized(), 250, 1)
	get_tree().current_scene.add_child(projectile)
	imp.timer.start()


func _on_timer_timeout() -> void:
	finished.emit(IDLE)
