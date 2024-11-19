extends StatusEffect
class_name Slow

var base_speed: float

func _init(time = 3) -> void:
	super._init(time)
	effect_name = "Slow"

func apply(target) -> void:
	super.apply(target)
	target.base_stats["speed"] *= 0.6
	
func remove(target) -> void:
	super.remove(target)
	target.base_stats["speed"] /= 0.6
