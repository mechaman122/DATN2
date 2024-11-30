extends Node2D

@export var animation_player: AnimationPlayer
@onready var label: Label = $Label

enum Rarity {COMMON, RARE, EPIC, LEGENDARY}

var base_drop_chance = {
	Rarity.COMMON : 0.6,
	Rarity.RARE : 0.25,
	Rarity.EPIC : 0.13,
	Rarity.LEGENDARY : 0.02
}

var weapon_drop_chance = 0.8

# access folder that contains all the items
var weapons_folder = "res://weapons/"
var collectible_folder = "res://collectibles/list"
var armor_folder = "res://armor/base_armors"

var touch_body: Node2D = null

func _ready() -> void:
	#randomize()
	label.text = "Press F to open"
	

func _process(delta: float) -> void:
	if touch_body != null && Input.is_action_just_pressed("ui_interact"):
		interact()


func get_random_drop(level: int) -> Rarity:
	var adjusted_drop_chance = adjust_drop_rates(base_drop_chance, level)
	var rand_value = randf()
	var cummulative_chance = 0.0

	for rarity in adjusted_drop_chance.keys():
		cummulative_chance += adjusted_drop_chance[rarity]
		if rand_value <= cummulative_chance:
			return rarity
		
	return Rarity.COMMON
	

# if treasure chest don't drop weapon, it will drop collectibles or armor
func get_random_item():
	var rand_value = randf()
	var extension = "tscn"
	var foundPaths = []
	if rand_value > 0.5:
		# drop collectibles
		foundPaths = getFilePathByExtension(collectible_folder, extension)
	else:
		# drop armor
		foundPaths = getFilePathByExtension(armor_folder, extension)
	var item = foundPaths[randi() % foundPaths.size()]
	# create a new instance of the collectible
	item = load(item)
	var new_item = item.instantiate()
	new_item.position = position
	get_parent().add_child(new_item)
	await(new_item.tree_entered)
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		new_item, "position", Vector2(new_item.position + Vector2(0,-1) * 30), 0.25
	).set_ease(Tween.EASE_OUT)
	await(tween.finished)


func adjust_drop_rates(base_chance: Dictionary, level: int) -> Dictionary:
	var adjusted_chance = {}
	
	var common_reduction = min(level * 0.01, 0.3) # up to 30% reduction
	var rare_increase = min(level * 0.005, 0.15) # up to 15% increase
	var epic_increase = min(level * 0.003, 0.1) # up to 10% increase
	var legendary_increase = min(level * 0.002, 0.05) # up to 5% increase

	adjusted_chance[Rarity.COMMON] = base_chance[Rarity.COMMON] - common_reduction
	adjusted_chance[Rarity.RARE] = base_chance[Rarity.RARE] + rare_increase
	adjusted_chance[Rarity.EPIC] = base_chance[Rarity.EPIC] + epic_increase
	adjusted_chance[Rarity.LEGENDARY] = base_chance[Rarity.LEGENDARY] + legendary_increase

	# normalize to ensure sum of all chances is 1
	var total_chance = adjusted_chance[Rarity.COMMON] + adjusted_chance[Rarity.RARE] + adjusted_chance[Rarity.EPIC] + adjusted_chance[Rarity.LEGENDARY]
	for rarity in adjusted_chance.keys():
		adjusted_chance[rarity] /= total_chance

	return adjusted_chance

func drop_weapon(rarity: Rarity) -> void:
	var weapon_list_path = ""
	if rarity == Rarity.COMMON:
		weapon_list_path = weapons_folder + "base_weapons/"
	elif rarity == Rarity.RARE:
		weapon_list_path = weapons_folder + "rare_weapons/"
	elif rarity == Rarity.EPIC:
		weapon_list_path = weapons_folder + "epic_weapons/"
	elif rarity == Rarity.LEGENDARY:
		weapon_list_path = weapons_folder + "legendary_weapons/"
	# get a random weapon from the base weapons folder
	var extension = "tscn"
	var foundPaths = getFilePathByExtension(weapon_list_path, extension)
	var weapon = foundPaths[randi() % foundPaths.size()]
	# create a new instance of the weapon
	weapon = load(weapon)
	var new_weapon = weapon.instantiate()
	new_weapon.position = position
	new_weapon.is_on_floor = true
	get_parent().add_child(new_weapon)
	await(new_weapon.tree_entered)
	#var throw_dir: Vector2 = Vector2(0, -1)
	#new_weapon.interpolate_pos(position, position + throw_dir * 20)
	#new_weapon.pickable_area.set_collision_mask_value(1, true)
	#new_weapon.pickable_area.set_collision_mask_value(2, true)

func interact():
	var rand_value = randf()
	if rand_value > weapon_drop_chance:
		get_random_item()
		#animation_player.play("open")
	else:
		# drop weapon
		var random_drop = get_random_drop(SavedData.level)
		#if random_drop != Rarity.COMMON:
			#animation_player.play("open_gem")
		#else :
			#animation_player.play("open")
		print("You got a ", random_drop, " item!")
		drop_weapon(random_drop)
	label.hide()
	SoundManager.play_sfx("open_chest")
	
func _on_pickable_area_body_entered(body: Node2D) -> void:
	if body is Player:
		label.show()
		touch_body = body


func _on_pickable_area_body_exited(body: Node2D) -> void:
	if body is Player:
		label.hide()
		touch_body = null


func getFilePathByExtension(directoryPath: String, extension: String, recursive: bool = true) -> Array:
	var dir: = DirAccess.open(directoryPath)
	if dir == null:
		print("Error opening directory")
		return []

	if dir.list_dir_begin() != OK:
		print("Error listing directory")
		return []

	var filePaths = []
	var fileName = dir.get_next()
	while fileName != "":
		if dir.current_is_dir():
			if recursive:
				filePaths.append(getFilePathByExtension(directoryPath + "/" + fileName, extension))
		elif fileName.get_extension() == extension:
			filePaths.append(directoryPath + "/" + fileName)
		fileName = dir.get_next()
	return filePaths
