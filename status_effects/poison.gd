extends StatusEffect
class_name Poison

var time_elapsed: int = 0 # 60 equals roughly 1s

func _init(time = 6) -> void:
	super._init(time)
	effect_name = "Poison"

func apply(target) -> void:
	super.apply(target)
	
	
func remove(target) -> void:
	super.remove(target)

func tick(target, delta: float) -> void:
	super.tick(target, delta)
	time_elapsed += 1
	if time_elapsed == 90:
		target.take_damage(damage_per_tick, source)
		time_elapsed = 0
