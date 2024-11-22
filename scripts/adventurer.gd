class_name Player extends CharacterBody2D

enum {UP, DOWN}

const DUST_SCENE: PackedScene = preload("res://scenes/dust.tscn")

var current_weapon
var current_armor

signal weapon_switched(prev_index: int, new_index: int)
signal weapon_picked_up(weapon_stats: WeaponStats)
signal weapon_dropped(index: int)
signal armor_equipped(armor_stats: ArmorItem)

@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var dash: GPUParticles2D = $DashParticles

#stats
@onready var health = $Health
@onready var armor =$Armor
var mana: int = 200:
	set(value):
		mana = value
		SavedData.mana = value
		get_node("Interface").mana_bar.change_value(mana, 200)
		print(mana)

var base_stats = {
	"damage" : 0,
	"crit" : 0.0,
	"atk_speed": 1,
	"speed" : 100.0
}:
	set(value):
		base_stats = value
		SavedData.base_stats = value.duplicate()

var modifiers = {
	"damage" : 1.0,
	"crit" : 1.0,
	"atk_speed": 1.0,
	"speed" : 1.0
}

var status_effects: Array[StatusEffect] = []

@onready var melee_hitbox = $MeleeHitbox/CollisionShape2D
@onready var weapons = get_node("Weapons")
@onready var armors = get_node("Armors")
@onready var dust_position = get_node("DustPosition")
@onready var interaction_manager = get_node("InteractionManager")

var has_weapon = false
var health_changed = false
var knockback: Vector2
var regen: bool = false
var regen_timer = 0
var evade_chance: float = 0

func _ready() -> void:
	emit_signal("weapon_picked_up", weapons.get_child(0).stats)
	emit_signal("armor_equipped", current_armor)
	_restore_prev_state()

# for testing purpose
func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_1:
			apply_status_effect(Stun.new())
		if event.keycode == KEY_2:
			apply_status_effect(Slow.new())
		if event.keycode == KEY_4:
			apply_status_effect(Heal.new())
		if event.keycode == KEY_5:
			apply_status_effect(Burn.new())
			
func _restore_prev_state() -> void:
	
	SavedData.allow_input = true
	health.max_health = SavedData.max_health
	health.health = SavedData.health
	armor.max_armor = SavedData.max_armor
	armor.armor = armor.max_armor
	mana = SavedData.mana
	base_stats = SavedData.base_stats.duplicate()
	
	for weapon in SavedData.weapons:
		weapon = weapon.duplicate()
		weapon.player_ref = self
		weapon.position = Vector2.ZERO
		weapons.add_child(weapon)
		weapon.hide()

		emit_signal("weapon_picked_up", weapon.stats)
		emit_signal("weapon_switched", weapons.get_child_count() - 2, weapons.get_child_count() - 1)
		
	current_weapon = weapons.get_child(SavedData.equipped_weapon_index)
	current_weapon.show()
	has_weapon = true
	
	if SavedData.equipped_armor != null:
		var equipped_armor = SavedData.equipped_armor.duplicate()
		armors.add_child(equipped_armor)
		current_armor = armors.get_child(0)
		emit_signal("armor_equipped", SavedData.equipped_armor)
	
	emit_signal("weapon_switched", weapons.get_child_count() - 1, SavedData.equipped_weapon_index)
	

	
func _process(delta: float) -> void:
	if !SavedData.allow_input:
		return
	var mouse_dir: Vector2 = (get_global_mouse_position() - global_position).normalized()
	
	animated_sprite.flip_h = mouse_dir.x < 0
	dash.emitting = (abs(velocity.x) >= 150 or abs(velocity.y) >= 150)

	if has_weapon:
		if not current_weapon.is_busy():
			if Input.is_action_just_released("ui_prev_weapon"):
				_switch_weapon(UP)
			elif Input.is_action_just_released("ui_next_weapon"):
				_switch_weapon(DOWN)
			elif Input.is_action_just_pressed("ui_drop_weapon"):
				_drop_weapon()
				
		current_weapon.move(mouse_dir)
		current_weapon.get_input()
	
	if Input.is_action_just_pressed("ui_interact"):
		interaction_manager.initiate_interaction()

# handle all physical stuff
func _physics_process(delta: float) -> void:
	reset_modifiers()
	
	regenerate(delta)
	
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
			
	# apply modifiers from armor
	if current_armor != null:
		for stat in current_armor.armor_stats.modifiers:
			modifiers[stat] += current_armor.armor_stats.modifiers[stat]
			
	current_weapon.weapon_anim.anim_player.speed_scale = current_weapon.stats.weapon_speed * modifiers["atk_speed"]
	
	#if current_weapon.stats.modifiers != null:
	for stat in current_weapon.stats.modifiers:
		modifiers[stat] += current_weapon.stats.modifiers[stat]
	
func _switch_weapon(direction: int) -> void:
	#if !has_weapon or weapons.get_child_count() == 1:
		#return
	var prev_index: int = current_weapon.get_index()
	var index: int = prev_index
	if direction == UP:
		index -= 1
		if index < 0:
			index = weapons.get_child_count() - 1
	else:
		index += 1
		if index > weapons.get_child_count() - 1:
			index = 0
			
	current_weapon.hide()
	current_weapon = weapons.get_child(index)
	current_weapon.show()
	
	SavedData.equipped_weapon_index = index
	print(index)
	
	emit_signal("weapon_switched", prev_index, index)
	print(current_weapon.player_ref)
	

func pick_up_weapon(weapon: Weapon2) -> void:
	SavedData.weapons.append(weapon.duplicate())
	
	var prev_index: int = SavedData.equipped_weapon_index
	var new_index: int = weapons.get_child_count()

	SavedData.equipped_weapon_index = new_index

	weapon.get_parent().call_deferred("remove_child", weapon)
	weapons.call_deferred("add_child", weapon)
	weapon.set_deferred("owner", weapons)
	current_weapon.hide()
	current_weapon.cancel_attack()
	
	current_weapon = weapon

	emit_signal("weapon_picked_up", weapon.stats)
	emit_signal("weapon_switched", prev_index, new_index)

	
func _drop_weapon() -> void:
	if !has_weapon or weapons.get_child_count() == 1:
		return
	SavedData.weapons.remove_at(current_weapon.get_index()-1 if current_weapon.get_index() > 0 else 0)
	var weapon_to_drop: Node2D = current_weapon
	_switch_weapon(UP)

	emit_signal("weapon_dropped", weapon_to_drop.get_index())

	weapons.call_deferred("remove_child", weapon_to_drop)
	get_parent().call_deferred("add_child", weapon_to_drop)
	weapon_to_drop.set_deferred("owner", get_parent())
	await(weapon_to_drop.tree_entered)
	weapon_to_drop.show()

	var throw_dir: Vector2 = (get_global_mouse_position() - position).normalized()
	weapon_to_drop.interpolate_pos(position, position + throw_dir * 50)
	weapon_to_drop.player_ref = null
	get_node("CollisionShape2D").disabled = true
	get_node("CollisionShape2D").disabled = false

func spawn_dust() -> void:
	var dust: Sprite2D = DUST_SCENE.instantiate()
	dust.position = dust_position.global_position
	get_parent().add_child(dust)


func equip_armor(armor_item: ArmorItem) -> void:
	armor.set_max_armor(armor.get_max_armor() + armor_item.armor_stats.armor)
	
	SavedData.equipped_armor = armor_item.duplicate()
	armor_item.get_parent().call_deferred("remove_child", armor_item)
	armors.call_deferred("add_child", armor_item)
	armor_item.set_deferred("owner", armors)
	
	current_armor = armor_item
	
	emit_signal("armor_equipped", armor_item)
	
	
func equip_different_armor(next: ArmorItem) -> void:
	var armor_to_drop: Node2D = current_armor
	if armor_to_drop.armor_stats.passive != null:
		armor_to_drop.armor_stats.passive.deactivate(self)
	armor.set_max_armor(armor.get_max_armor() - armor_to_drop.armor_stats.armor)
	
	armors.call_deferred("remove_child", armor_to_drop)
	get_parent().call_deferred("add_child", armor_to_drop)
	armor_to_drop.set_deferred("owner", get_parent())
	await(armor_to_drop.tree_entered)
	
	var throw_dir: Vector2 = (get_global_mouse_position() - position).normalized()
	armor_to_drop.interpolate_pos(position, position + throw_dir * 30)
	
	equip_armor(next)


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
		

func take_damage(_damage: int, source, is_crit) -> void:
	if randf() < evade_chance:
		print("miss")
	else:
		if armor.armor > 0:
			var diff = armor.armor - _damage
			if diff >= 0:
				armor.armor -= _damage
			else:
				armor.armor = 0
				health.health -= diff
		else:
			health.health -= _damage


func regenerate(delta: float) -> void:
	if !regen:
		return
	if health.health * 2 < health.max_health:
		if regen_timer <= 0:
			health.health += 1
			regen_timer = 4
		else:
			regen_timer -= delta

func reset_modifiers():
	for stat in modifiers:
		modifiers[stat] = 1

func get_curr_stats() -> Dictionary:
	var curr_stats = {}
	for stat in base_stats:
		# Apply the modifier if it exists; otherwise, use the base value
		if modifiers.has(stat):
			curr_stats[stat] = base_stats[stat] * modifiers[stat]
		else:
			curr_stats[stat] = base_stats[stat]
	return curr_stats
