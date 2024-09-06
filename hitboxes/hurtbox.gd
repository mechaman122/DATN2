class_name Hurtbox
extends Area2D


signal received_damage(damage: int)

@export var health: Health

func _ready() -> void:
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox: Hitbox) -> void:
	if hitbox != null:
		health.health -= hitbox.damage
		received_damage.emit(hitbox.damage)
		set_knockback_direction(hitbox)

func set_knockback_direction(hitbox: Hitbox) -> void:
	var direction = (hitbox.global_position - global_position).normalized()
	get_parent().knockback_direction = direction
