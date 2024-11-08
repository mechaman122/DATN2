extends StatusEffect
class_name Slow

func _init(time = 3) -> void:
	super._init(time)
	effect_name = "Slow"

func apply(target) -> void:
	super.apply(target)
	target.speed = target.speed * 0.25
	target.bonus_speed = target.bonus_speed * 0.25
	
func remove(target) -> void:
	super.remove(target)
	target.speed = SavedData.speed
	target.bonus_speed = SavedData.bonus_speed
