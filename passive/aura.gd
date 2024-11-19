extends Passive
class_name Aura

var aura_area = preload("res://passive/aura_area.tscn")


func activate(target, value):
	super.activate(target, value)
	var aura = aura_area.instantiate()
	target.add_child(aura)
	aura.set_aura(value)

func deactivate(target):
	var aura = target.get_node("AuraArea")
	aura.queue_free()
