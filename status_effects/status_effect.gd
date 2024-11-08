extends Resource
class_name StatusEffect

var duration: float
var effect_name: String

func _init(time = 3) -> void:
	duration = time
	
func apply(target) -> void:
	print(effect_name + " affected on " + target.name)
	
func remove(target) -> void:
	print(effect_name + " removed from " + target.name)

func get_effect_name() -> String:
	return effect_name
