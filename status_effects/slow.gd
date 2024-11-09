extends StatusEffect
class_name Slow

func _init(time = 3) -> void:
	super._init(time)
	effect_name = "Slow"

func apply(target) -> void:
	super.apply(target)
	target.curr_stats["speed"] *= 0.25
	
func remove(target) -> void:
	super.remove(target)
	target.curr_stats["speed"] = target.base_stats["speed"]
