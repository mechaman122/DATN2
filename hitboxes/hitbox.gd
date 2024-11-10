class_name Hitbox
extends Area2D

@export var damage: int = 1: set = set_damage, get = get_damage
@export var knockback_strength = 10
var status_effects: Array[StatusEffect] = []

func set_damage(value: int):
	damage = value

func get_damage() -> int:
	return damage
