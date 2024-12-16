extends StaticBody2D
class_name Destructible


@export var animation_player: AnimationPlayer
@onready var collision_shape = $CollisionShape2D
var knockback = Vector2()
@export var health : int
var breaked = false

func take_damage(_damage: int, source, is_crit: bool = false) -> void:
	health -= _damage
	if health <= 0:
		breaked = true
		_on_destroyed()
		
func apply_status_effect(e):
	pass
	
func _on_destroyed() -> void :
	animation_player.play("break")
	collision_shape.set_deferred("disabled", true)
