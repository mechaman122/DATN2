extends StatusEffect
class_name Heal

func _init() -> void:
	effect_name = "Heal"

func apply(target) -> void:
	super.apply(target)
	target.health.health += 1
	
func remove(target) -> void:
	super.remove(target)
