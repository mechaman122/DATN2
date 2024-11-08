extends StatusEffect
class_name Heal

func _init(time = 3) -> void:
	super._init(time)
	effect_name = "Heal"

func apply(target) -> void:
	super.apply(target)
	target.health.health += 1
	
func remove(target) -> void:
	super.remove(target)
