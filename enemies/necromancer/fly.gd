extends Node2D

var enemy_exited: bool = false

var direction: Vector2 = Vector2.ZERO
var knife_speed: int = 0
var stat_multiplier: float = 1.0


func launch(initial_position: Vector2, dir: Vector2, speed: int, stat_mul: float) -> void:
	position = initial_position
	direction = dir
	knife_speed = speed
	stat_multiplier = stat_mul

	rotation += dir.angle()


func _physics_process(delta: float) -> void:
	position += direction * knife_speed * delta
