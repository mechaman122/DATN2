extends StatusEffect
class_name Bleed

var time_elapsed: int = 0 # 60 equals roughly 1s

func _init() -> void:
	effect_name = "Bleed"
	duration = 2

func apply(target) -> void:
	super.apply(target)
	SoundManager.play_sfx("bleed_sfx")
	
func remove(target) -> void:
	super.remove(target)

func tick(target, delta: float) -> void:
	super.tick(target, delta)
	time_elapsed += 1
	if time_elapsed == 25:
		target.take_damage(damage_per_tick, source)
		time_elapsed = 0
