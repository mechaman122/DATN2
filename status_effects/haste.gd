extends StatusEffect
class_name Haste

func _init(time = 3) -> void:
	super._init(time)
	effect_name = "Haste"

func apply(target) -> void:
	super.apply(target)
	target.curr_stats["speed"] *= 3
	
func remove(target) -> void:
	super.remove(target)
	target.curr_stats["speed"] = target.base_stats["speed"]
