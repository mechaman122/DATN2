extends Node2D

class_name WeaponAnimation

@export var anim_player: AnimationPlayer
@export var sprite: Sprite2D
@export var charge_particles: GPUParticles2D
@export var hitbox: Hitbox
@export var projectile_sprite: Sprite2D

# this is for ranged weapon
const ARROW_SCENE = preload("res://weapons/projectile/arrow.tscn")
const MAGIC_PROJECTILE_SCENE = preload("res://weapons/projectile/magic_projectile.tscn")
const SLASH_SCENE = preload("res://weapons/projectile/slash.tscn")
@export var shooting_position: Marker2D


func get_input() -> void:
	if !SavedData.allow_input:
		return
	if Input.is_action_just_pressed("ui_attack") and not anim_player.is_playing():
		anim_player.play("charge")
	elif Input.is_action_just_released("ui_attack"):
		if anim_player.is_playing() and anim_player.current_animation == "charge":
			if get_parent().stats2["crit"] >= randf():
				hitbox.damage = get_parent().stats2["damage"] * 2
			else: 
				hitbox.damage = get_parent().stats2["damage"]
			anim_player.play("attack")
		elif charge_particles.emitting:
			hitbox.damage = get_parent().stats2["damage"] * 3
			anim_player.play("charged_attack")	


func shoot(weapon_type: String = "Bow", spd: int = 500, offset: float = 0) -> void:
	var projectile_to_shoot = MAGIC_PROJECTILE_SCENE.instantiate() if weapon_type == "Staff" else ARROW_SCENE.instantiate() 
	if weapon_type == "Staff":
		projectile_to_shoot = MAGIC_PROJECTILE_SCENE.instantiate()
	elif weapon_type == "Bow":
		projectile_to_shoot = ARROW_SCENE.instantiate()
	else:
		projectile_to_shoot = SLASH_SCENE.instantiate()
		
	projectile_to_shoot.visible = true
	get_tree().current_scene.add_child(projectile_to_shoot)
	var shooting_pos = shooting_position.global_position
	projectile_to_shoot.sprite.texture = projectile_sprite.texture
	
	for i in range(hitbox.status_effects.size()):
		projectile_to_shoot.get_node("Hitbox").status_effects.append(hitbox.status_effects[i])
	
	if weapon_type == "Staff":
		var mouse_dir = get_global_mouse_position()
		projectile_to_shoot.launch(shooting_pos, shooting_pos.direction_to(mouse_dir).rotated(deg_to_rad(offset)), spd, hitbox.damage)
	else:
		projectile_to_shoot.launch(shooting_pos, global_position.direction_to(shooting_pos), spd, hitbox.damage)
