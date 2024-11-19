extends Passive
class_name Evade

func _init(target, value) -> void:
	pass
	

func activate(target, value):
	target.evade_chance = 0.8
