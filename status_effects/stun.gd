extends StatusEffect
class_name Stun

func _init(time = 3) -> void:
	super._init(time)
	effect_name = "Stun"

func apply(target) -> void:
	super.apply(target)
	target.speed = 0
	target.bonus_speed = 0
	SavedData.allow_input = false
	
func remove(target) -> void:
	super.remove(target)
	target.speed = SavedData.speed
	target.bonus_speed = SavedData.bonus_speed
	SavedData.allow_input = true
