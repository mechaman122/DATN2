class_name Hurtbox
extends Area2D


func _init() -> void:
	monitorable = false
	
	collision_mask = 5

func _ready() -> void:
	connect("area_entered", _on_area_entered)
	
func _on_area_entered(hitbox: Hitbox) -> void:
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
		for effect in hitbox.status_effects:
			if randf() <= effect.chance_to_proc:
				var e = effect.duplicate(true)
				owner.apply_status_effect(e)
		set_knockback_direction(hitbox)

		
func set_knockback_direction(hitbox: Hitbox) -> void:
	var direction = (global_position.direction_to(hitbox.global_position)) * -1
	var force = direction * hitbox.knockback_strength
	get_parent().knockback = force
