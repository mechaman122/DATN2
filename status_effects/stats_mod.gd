extends StatusEffect
class_name StatusMod

@export var damage_mul: int = 0
@export var crit_mul: float = 0
@export var atk_speed_mul: float = 1
@export var speed_mul: float = 1

func _init() -> void:
	effect_name = "StatusMod"
	
func apply(target) -> void:
	super.apply(target)
	target.base_stats["damage"] = SavedData.base_stats["damage"] + damage_mul
	target.base_stats["crit"] = SavedData.base_stats["crit"] + crit_mul
	target.base_stats["atk_speed"] = SavedData.base_stats["atk_speed"] * speed_mul
	target.base_stats["speed"] = SavedData.base_stats["speed"] * speed_mul
	
	
func remove(target) -> void:
	super.remove(target)
	target.base_stats["damage"] = SavedData.base_stats["damage"]
	target.base_stats["crit"] = SavedData.base_stats["crit"]
	target.base_stats["atk_speed"] = SavedData.base_stats["atk_speed"]
	target.base_stats["speed"] = SavedData.base_stats["speed"]
	SoundManager.play_sfx("slow_down_sfx")
