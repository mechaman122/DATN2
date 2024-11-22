extends Passive
class_name Evade

func activate(target):
	target.evade_chance += value

func deactivate(target):
	target.evade_chance -= value
