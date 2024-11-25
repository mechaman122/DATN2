extends Node

var max_health: int = 6
var health: int = 6
var max_armor: int = 4
var mana: int = 200

var base_stats = {
	"damage": 0,
	"crit": 0,
	"atk_speed": 0,
	"speed": 100
}

var allow_input = true

var weapons: Array = []
var equipped_weapon_index: int = 0
var equipped_armor: ArmorItem = null

var passives: Dictionary

var level: int = 1

func save_data() -> PlayerContinueData:
	var continue_data = PlayerContinueData.new()
	
	continue_data.base_stats = base_stats.duplicate(true)
	#if equipped_armor != null:
		#continue_data.equipped_armor = equipped_armor.duplicate(true)
	#continue_data.weapons = weapons.duplicate(true)
	
	get_tree().call_group("game_events", "on_save_game", continue_data)
		
	if equipped_armor != null:
		var armor_to_save = ArmorContinueData.new()
		armor_to_save.scene_path = equipped_armor.scene_file_path
		armor_to_save.stats = equipped_armor.armor_stats.duplicate(true)
		continue_data.equipped_armor = armor_to_save
	
	continue_data.max_health = max_health
	continue_data.health = health
	continue_data.max_armor = max_armor
	continue_data.mana = mana
	
	continue_data.level = level
	
	return continue_data

func load_data(data_to_load: PlayerContinueData):
	base_stats = data_to_load.base_stats.duplicate(true)
	
	weapons = []
	
	for weapon in data_to_load.weapons:
		var scene = load(weapon.scene_path) as PackedScene
		var restored_weapon = scene.instantiate()
		restored_weapon.stats = weapon.stats.duplicate(true)
		weapons.append(restored_weapon)
		
	equipped_armor = null
	var scene = load(data_to_load.equipped_armor.scene_path) as PackedScene
	var restored_armor = scene.instantiate() as ArmorItem
	restored_armor.armor_stats = data_to_load.equipped_armor.stats.duplicate(true)
	equipped_armor = restored_armor
	
	max_health = data_to_load.max_health
	health = data_to_load.health
	max_armor = data_to_load.max_armor
	mana = data_to_load.mana
	
	level = data_to_load.level
