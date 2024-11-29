extends StatusEffect
class_name Slow

@export var speed_mul: float = 0.6
var base_speed: float

func _init() -> void:
	effect_name = "Slow"

func apply(target) -> void:
	super.apply(target)
	target.base_stats["speed"] *= speed_mul
	
func remove(target) -> void:
	super.remove(target)
	target.base_stats["speed"] = 100
