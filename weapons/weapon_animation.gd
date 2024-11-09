extends Node2D

class_name WeaponAnimation

@export var anim_player: AnimationPlayer
@export var sprite: Sprite2D
@export var charge_particles: GPUParticles2D
@export var hitbox: Hitbox

# this is for ranged weapon
const ARROW_SCENE = preload("res://weapons/projectile/arrow.tscn")
const FIREBALL_SCENE = preload("res://weapons/projectile/fireball.tscn")
@export var shooting_position: Marker2D


func get_input() -> void:
	if !SavedData.allow_input:
		return
	if Input.is_action_just_pressed("ui_attack") and not anim_player.is_playing():
		anim_player.play("charge")
	elif Input.is_action_just_released("ui_attack"):
		if get_parent().stats2["crit"] >= randf():
			hitbox.damage = get_parent().stats2["damage"] * 2
		else: 
			hitbox.damage = get_parent().stats2["damage"]
		if anim_player.is_playing() and anim_player.current_animation == "charge":
			anim_player.play("attack")
		elif charge_particles.emitting:
			anim_player.play("charged_attack")	


func shoot(weapon_type: String = "Bow", spd: int = 500, offset: float = 0) -> void:
	var projectile_to_shoot = ARROW_SCENE.instantiate() if weapon_type == "Bow" else FIREBALL_SCENE.instantiate()
	projectile_to_shoot.visible = true
	get_tree().current_scene.add_child(projectile_to_shoot)
	var shooting_pos = shooting_position.global_position
	
	if weapon_type == "Staff":
		var mouse_dir = get_global_mouse_position()
		projectile_to_shoot.launch(shooting_pos, shooting_pos.direction_to(mouse_dir).rotated(deg_to_rad(offset)), spd, hitbox.damage)
	else:
		projectile_to_shoot.launch(shooting_pos, global_position.direction_to(shooting_pos), spd, hitbox.damage)
