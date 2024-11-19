extends Node2D

class_name WeaponAnimation

@export var anim_player: AnimationPlayer
@export var sprite: Sprite2D
@export var charge_particles: GPUParticles2D
@export var melee_hitbox: Hitbox

@export var projectile_sprite: Sprite2D

# this is for ranged weapon
const ARROW_SCENE = preload("res://weapons/projectile/arrow.tscn")
const MAGIC_PROJECTILE_SCENE = preload("res://weapons/projectile/magic_projectile.tscn")
const SLASH_SCENE = preload("res://weapons/projectile/slash.tscn")
@export var shooting_position: Marker2D

var curr_damage: int

func get_input() -> void:
	if !SavedData.allow_input:
		return
	if Input.is_action_just_pressed("ui_attack") and not anim_player.is_playing():
		anim_player.play("charge")
	elif Input.is_action_just_released("ui_attack"):
		if anim_player.is_playing() and anim_player.current_animation == "charge":
			anim_player.play("attack")
			curr_damage = get_parent().stats.weapon_damage
		elif charge_particles.emitting:
			anim_player.play("charged_attack")
			curr_damage = roundi(get_parent().stats.weapon_damage * 1.5)
		if randf() <= get_parent().stats.weapon_crit:
			curr_damage = roundi(curr_damage * 1.5)
		if melee_hitbox != null:
			melee_hitbox.damage = curr_damage
	
func shoot(weapon_type: String = "Bow", spd: int = 500, offset: float = 0) -> void:
	var projectile
	if weapon_type == "Staff":
		projectile = MAGIC_PROJECTILE_SCENE.instantiate()
	elif weapon_type == "Bow":
		projectile = ARROW_SCENE.instantiate()
	else:
		projectile = SLASH_SCENE.instantiate()
		
		
	projectile.position = shooting_position.global_position
	projectile.direction = global_position.direction_to(get_global_mouse_position()).rotated(deg_to_rad(offset))
	projectile.sprite.texture = projectile_sprite.texture
	
	set_hitbox(projectile.get_node("Hitbox"))
	
	add_child(projectile)

func set_hitbox(hitbox: Hitbox):
	hitbox.damage = curr_damage
	hitbox.source = get_parent()
	hitbox.append_effect(get_parent().stats.status_effects)
