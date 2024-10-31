extends Node2D

class_name Projectile

var direction = Vector2.ZERO
var speed: float = 0

func _ready() -> void:
	pass

func launch(init_pos: Vector2, dir: Vector2, spd: float, dmg: int) -> void:
	get_node("Hitbox").damage = dmg
	position = init_pos
	self.direction = dir
	self.speed = spd
	rotation += dir.angle() - deg_to_rad(45)

func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_life_time_timeout() -> void:
	queue_free()
