class_name Hitbox
extends Area2D

@export var damage: int = 1: set = set_damage, get = get_damage
@export var knockback_strength = 10
@onready var collision_shape = $CollisionShape2D
var is_crit: bool = false

var status_effects: Array[StatusEffect] = []
var source

func _init() -> void:
	collision_mask = 0
	
	collision_layer = 5

func set_damage(value: int):
	damage = value

func get_damage() -> int:
	return damage

func set_disabled(is_disabled: bool) -> void:
	collision_shape.set_deferred("disabled", is_disabled)

func append_effect(effects: Array[StatusEffect]):
	for effect in effects:
		for i in range(status_effects.size()):
			if status_effects[i].get_effect_name() == effect.get_effect_name():
				status_effects[i].duration = effect.duration
				return
		var e = effect.duplicate(true)
		e.source = source
		status_effects.append(e)
