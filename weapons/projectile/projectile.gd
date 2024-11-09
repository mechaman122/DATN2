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
	rotation += dir.angle()

func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_life_time_timeout() -> void:
	queue_free()


func _on_hitbox_area_entered(hurtbox: Hurtbox) -> void:
	queue_free()
