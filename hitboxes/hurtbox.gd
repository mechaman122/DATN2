class_name Hurtbox
extends Area2D


signal received_damage(damage: int)

@export var health: Health
@export var armor: Armor

func _ready() -> void:
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox: Hitbox) -> void:
	if hitbox != null:
		if armor != null && armor.get_armor() > 0:
			armor.armor -= hitbox.damage
		else:
			health.health -= hitbox.damage
			received_damage.emit(hitbox.damage)
			set_knockback_direction(hitbox)

func set_knockback_direction(hitbox: Hitbox) -> void:
	var direction = (global_position.direction_to(hitbox.global_position)) * -1
	var force = direction * hitbox.knockback_strength
	get_parent().knockback = force
