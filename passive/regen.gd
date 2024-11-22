extends Passive
class_name Regen
	

func activate(target):
	target.regen = true
	

func deactivate(target):
	target.regen = false
