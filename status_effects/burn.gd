extends StatusEffect
class_name Burn

var time_elapsed: int = 0 # 60 equals roughly 1s

func _init() -> void:
	effect_name = "Burn"
	icon_texture = load("res://assets/sprites/rpg_icon/Individual icons (16x16)/141.png")

func apply(target) -> void:
	super.apply(target)
	SoundManager.play_sfx("fire_sfx")
	
func remove(target) -> void:
	super.remove(target)

func tick(target, delta: float) -> void:
	super.tick(target, delta)
	time_elapsed += 1
	if time_elapsed == 60:
		target.take_damage(damage_per_tick, source)
		time_elapsed = 0
