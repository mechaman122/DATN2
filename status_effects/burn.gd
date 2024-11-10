extends StatusEffect
class_name Burn

var time_elapsed: int = 0 # 60 equals roughly 1s

func _init(time = 3) -> void:
	super._init(time)
	effect_name = "Burn"

func apply(target) -> void:
	super.apply(target)
	
	
func remove(target) -> void:
	super.remove(target)

func tick(target, delta: float) -> void:
	super.tick(target, delta)
	time_elapsed += 1
	if time_elapsed == 60:
		if target.armor != null:
			if target.armor.armor > 0:
				target.armor.armor -= damage_per_tick
		else: 
			target.health.health -= damage_per_tick
			print(target.health.health)
		time_elapsed = 0
