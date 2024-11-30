extends StatusEffect
class_name Slow

@export var speed_mul: float = 0.6
var base_speed: float

func _init() -> void:
	effect_name = "Slow"

func apply(target) -> void:
	super.apply(target)
	if target is Player:
		target.base_stats["speed"] *= speed_mul
	else:
		base_speed = target.speed
		target.speed *= speed_mul
func remove(target) -> void:
	super.remove(target)
	if target is Player:
		target.base_stats["speed"] = 100
	else:
		target.speed = base_speed
