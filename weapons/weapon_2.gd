extends Node2D

class_name Weapon2

@export var is_on_floor: bool = false
@export var weapon_anim: WeaponAnimation
@onready var pickable_area: Area2D = get_node("PickableArea")
var tween: Tween = null

@export var stats: WeaponStats:
	set(value):
		stats = value
		#weapon_anim.sprite.texture = value.texture


func _ready() -> void:
	#if self.get_parent().name != "Weapons":
		#is_on_floor = true
	if not stats.is_ranged:
		weapon_anim.sprite.texture = stats.texture
	else:
		weapon_anim.sprite.texture = stats.texture
	weapon_anim.hitbox.damage = stats.damage
	if not is_on_floor:
		pickable_area.set_collision_mask_value(1, false)
		pickable_area.set_collision_mask_value(2, false)
	#else:
		#pickable_area.set_collision_mask_value(1, true)
		#pickable_area.set_collision_mask_value(2, true)


func get_input() -> void:
	weapon_anim.get_input()
	

func move(mouse_dir: Vector2) -> void:
	if stats.is_ranged:
		var parent = get_parent()
		parent.rotation_degrees = rad_to_deg(mouse_dir.angle())
		if mouse_dir.x < 0:
			parent.scale.y = -1
		else:
			parent.scale.y = 1
	else:
		if not weapon_anim.anim_player.is_playing() or weapon_anim.anim_player.current_animation == "charge":
			var parent = get_parent()
			parent.rotation = mouse_dir.angle()
			if parent.scale.y == 1 and mouse_dir.x < 0:
				parent.scale.y = -1
			elif parent.scale.y == -1 and mouse_dir.x > 0:
				parent.scale.y = 1


func is_busy():
	if weapon_anim.anim_player.is_playing() or weapon_anim.charge_particles.emitting:
		return true
	return false


func cancel_attack() -> void:
	weapon_anim.anim_player.call_deferred("play", "cancel_attack")


func _on_pickable_area_body_entered(body: Node2D) -> void:
	if body is Player:
		pickable_area.set_collision_mask_value(1, false)
		pickable_area.set_collision_mask_value(2, false)
		body.pick_up_weapon(self)
		position = Vector2.ZERO
	elif body == null:
		tween.kill()
		pickable_area.set_collision_mask_value(2, true)


func interpolate_pos(init_pos: Vector2, final_pos: Vector2) -> void:
	position = init_pos
	tween = create_tween()
	tween.tween_property(self, "position", final_pos, 0.8).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.connect("finished", _on_tween_completed)
	pickable_area.set_collision_mask_value(1, false)


func _on_tween_completed() -> void:
	pickable_area.set_collision_mask_value(2, true)


func get_texture() -> Texture:
	return weapon_anim.sprite.texture
