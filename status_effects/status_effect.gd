extends Resource
class_name StatusEffect

var duration: float
var effect_name: String
var source
@export var damage_per_tick: int = 1
@export var chance_to_proc: float = 0.3
@export var icon_texture: Texture2D

func _init(time = 3) -> void:
	duration = time
	
func apply(target) -> void:
	print(effect_name + " affected on " + target.name)
	
func remove(target) -> void:
	print(effect_name + " removed from " + target.name)

func tick(target, delta: float) -> void:
	if duration <= 0:
		remove(target)

func get_effect_name() -> String:
	return effect_name
