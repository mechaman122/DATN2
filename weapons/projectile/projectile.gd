extends Node2D

class_name Projectile

var direction = Vector2.ZERO
var speed: float = 0

func _ready() -> void:
	pass

func launch(init_pos: Vector2, dir: Vector2, spd: float) -> void:
	position = init_pos
	self.direction = dir
	self.speed = spd
	rotation += dir.angle()

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	if !get_viewport().get_visible_rect().has_point(position):
		queue_free()