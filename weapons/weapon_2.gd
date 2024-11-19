extends Node2D

class_name Weapon2


@export var is_on_floor: bool = false
@export var weapon_anim: WeaponAnimation
@onready var pickable_area: Area2D = get_node("PickableArea")
var tween: Tween = null
var player_ref: Node2D


# var passives: Array[Passive]
var status_effects: Array[StatusEffect]

@export var stats: WeaponStats:
	set(value):
		stats = value
			


func _ready() -> void:
	#if self.get_parent().name != "Weapons":
		#is_on_floor = true
	if not stats.is_ranged:
		weapon_anim.sprite.texture = stats.texture
		weapon_anim.set_hitbox(weapon_anim.melee_hitbox)
	else:
		weapon_anim.sprite.texture = stats.animated_texture if stats.animated_texture != null else stats.texture
	#weapon_anim.hitbox.damage = stats.damage
	if not is_on_floor:
		pickable_area.set_collision_mask_value(1, false)
		pickable_area.set_collision_mask_value(2, false)
		player_ref = get_parent().get_parent()
	#else:
		#pickable_area.set_collision_mask_value(1, true)
		#pickable_area.set_collision_mask_value(2, true)
	EventBus.enemy_died.connect(gain_xp)

func _process(delta: float) -> void:
	check_xp()

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
	Popups.item_popup(Rect2i(Vector2i(global_position), Vector2i(0,0)), stats)
	if body is Player:
		if body.weapons.get_child_count() < 3:
			pickable_area.set_collision_mask_value(1, false)
			pickable_area.set_collision_mask_value(2, false)
			body.pick_up_weapon(self)
			position = Vector2.ZERO
			player_ref = body
	elif body == null:
		tween.kill()
		pickable_area.set_collision_mask_value(2, true)


func _on_pickable_area_body_exited(body: Node2D) -> void:
	Popups.item_hidepopup()
	

func interpolate_pos(init_pos: Vector2, final_pos: Vector2) -> void:
	position = init_pos
	tween = create_tween()
	tween.tween_property(self, "position", final_pos, 0.8).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.connect("finished", _on_tween_completed)
	pickable_area.set_collision_mask_value(1, false)


func _on_tween_completed() -> void:
	pickable_area.set_collision_mask_value(2, true)


func get_texture() -> Texture:
	#return weapon_anim.sprite.texture
	return stats.texture

func is_upgradable() -> bool:
	if stats.level <= stats.upgrades.size():
		return true
	return false


func upgrade_weapon():
	if not is_upgradable():
		return
		
	var upgrade = stats.upgrades[stats.level - 1]
	
	stats.weapon_damage += upgrade.weapon_damage
	stats.weapon_crit += upgrade.weapon_crit
	stats.weapon_speed += upgrade.weapon_speed
	
	stats.level += 1


func gain_xp(source):
	if player_ref != null && self == source:
		stats.xp += 1

	
func check_xp():
	if stats.xp >= stats.total_xp:
		stats.xp = 0
		get_parent().get_parent().get_node("Interface").get_node("UpgradeOptions").show_option()
