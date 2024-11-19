extends Node2D

@onready var effect_container = get_node("StatusEffectContainer/HBoxContainer")
@onready var health = get_node("Health")
var armor
var knockback = Vector2()
var status_effects: Array[StatusEffect]

func _physics_process(delta: float) -> void:
	
	# apply status effect
	for i in range(status_effects.size()):
		var effect = status_effects[i]
		effect.tick(self, delta)
		effect.duration -= delta
		
		if effect.duration < 0:
			status_effects.remove_at(i)
			effect.remove(self)
			for y in effect_container.get_children():
				if y.name == effect.get_effect_name():
					y.queue_free()
			print(status_effects)
			reset_status_effect()
			break

func apply_status_effect(effect: StatusEffect):
	for i in range(status_effects.size()):
		if status_effects[i].get_effect_name() == effect.get_effect_name():
			status_effects[i].duration = effect.duration
			return
			
	status_effects.append(effect)
	var effect_icon = TextureRect.new()
	effect_icon.texture = effect.icon_texture
	effect_icon.name = effect.get_effect_name()
	effect_container.add_child(effect_icon)
	effect.apply(self)
	
	print(status_effects)

func reset_status_effect():
	for i in status_effects:
		i.apply(self)
		

func take_damage(_damage: int, source) -> void:
	if armor!= null && armor.armor > 0:
		armor.armor -= _damage
	else:
		health.health -= _damage
		$AnimationPlayer.play("hit")
		print(source)
		EventBus.emit_signal("enemy_died", source)
