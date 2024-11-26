#extends WeaponAnimation
extends Node2D
class_name GunAnim

@export var bullet: PackedScene
@export var bullet_count: int = 1
@export_range(0, 360) var arc: float = 0
@export_range(0, 20) var fire_rate: float = 2.0
@export_range(200, 500) var bullet_speed: float = 200

@onready var sprite = get_node("Sprite2D")
@onready var anim_player = get_node("AnimationPlayer")
@onready var charge_particles = get_node("Effects/ChargeParticles")
@onready var barrel_position = get_node("Effects/BarrelPosition")

var can_shoot = true
var curr_damage: int = 0
var curr_fire_rate: float = 0
var is_crit: bool = false

func get_input():
	if !SavedData.allow_input:
		return
	if SavedData.mana <= 0:
		return
	if Input.is_action_pressed("ui_attack") and can_shoot:
		curr_fire_rate = min(fire_rate * get_parent().stats.weapon_speed, 20)
		anim_player.play("attack")
		shoot(bullet_speed)
		get_parent().player_ref.mana -= get_parent().stats.mana
		
		play_sfx("gun_sfx")
	
	
func shoot(speed: float) -> void:
	if can_shoot:
		can_shoot = false
		for i in bullet_count:
			var new_bullet = bullet.instantiate()
			new_bullet.position = barrel_position.global_position if barrel_position else global_position
			new_bullet.speed = speed
			
			curr_damage = get_parent().stats.weapon_damage
			is_crit = (randf() < get_parent().stats.weapon_crit)
			if is_crit:
				curr_damage = roundi(curr_damage * 1.5)
			set_hitbox(new_bullet.get_node("Hitbox"))
			
			if bullet_count == 1:
				new_bullet.rotation = global_rotation
			else:
				var arc_rad = deg_to_rad(arc)
				var increment = arc_rad / (bullet_count - 1)
				new_bullet.global_rotation = (
					global_rotation + 
					increment * i -
					arc_rad / 2
				)
			get_tree().root.call_deferred("add_child", new_bullet)
		await get_tree().create_timer(1/curr_fire_rate).timeout
		can_shoot = true
	
func set_hitbox(hitbox: Hitbox):
	hitbox.is_crit = is_crit
	hitbox.damage = curr_damage
	hitbox.source = get_parent()
	hitbox.append_effect(get_parent().stats.status_effects)
	
func play_sfx(sfx_name: String):
	SoundManager.play_sfx(sfx_name, 0, -20)
