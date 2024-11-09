extends StatusEffect
class_name Stun

var base_speed: float

func _init(time = 3) -> void:
	super._init(time)
	effect_name = "Stun"

func apply(target) -> void:
	super.apply(target)
	base_speed = target.base_stats["speed"]
	target.base_stats["speed"] = 0
	target.animation_player.play("stun")
	SavedData.allow_input = false
	
func remove(target) -> void:
	super.remove(target)
	target.base_stats["speed"] = base_speed
	target.animation_player.play("idle")
	SavedData.allow_input = true
