extends Node2D

var status_effects: Array[StatusEffect]

@onready var health = get_node("Health")
var armor
var knockback = Vector2()

func _physics_process(delta: float) -> void:
	
	# apply status effect
	for i in range(status_effects.size()):
		var effect = status_effects[i]
		effect.tick(self, delta)
		effect.duration -= delta
		
		if effect.duration < 0:
			status_effects.remove_at(i)
			effect.remove(self)
			print(status_effects)
			reset_status_effect()
			break

func apply_status_effect(effect):
	for i in range(status_effects.size()):
		if status_effects[i].get_effect_name() == effect.get_effect_name():
			status_effects[i].duration = effect.duration
			return
			
	status_effects.append(effect)
	effect.apply(self)
	print(status_effects)

func reset_status_effect():
	for i in status_effects:
		i.apply(self)
		
