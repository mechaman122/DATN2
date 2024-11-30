extends CanvasLayer

const INVENTORY_ITEM_SCENE: PackedScene = preload("res://inventory/inventory_item.tscn")

@onready var health_bar = $HealthBar
@onready var health = get_parent().get_node("Health")

@onready var armor_bar = $ArmorBar
@onready var armor = get_parent().get_node("Armor")

@onready var mana_bar = $ManaBar

@onready var inventory: HBoxContainer = get_node("PanelContainer/Inventory")
@onready var armor_inventory: PanelContainer = get_node("ArmorContainer/InventoryItem")
@onready var level_label: Label = get_node("LevelLabel")
@onready var player = get_parent()

var rng = RandomNumberGenerator.new()
var curr_bgm_name = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_label.text = "Floor " + str(SavedData.level)
	
	health.max_health_changed.connect(_on_max_health_changed)
	health.health_changed.connect(_on_health_changed)

	armor.max_armor_changed.connect(_on_max_armor_changed)
	armor.armor_changed.connect(_on_armor_changed)
	
	mana_bar.change_max_value(200)
	$PauseScreen.hide()
	
	SoundManager.stop_all()
	rng.randomize()
	#play_bgm()

func _process(delta: float) -> void:
	if !SoundManager.is_playing(curr_bgm_name):
		#play_bgm()
		pass

func _on_health_changed(diff: int) -> void:
	health_bar.change_value(health.get_health(), health.get_max_health())
	if diff < 0:
		player.health_changed = true


func _on_max_health_changed(diff: int) -> void:
	health_bar.change_max_value(health.get_max_health())


func _on_armor_changed(diff: int) -> void:
	armor_bar.change_value(armor.get_armor(), armor.get_max_armor())
	

func _on_max_armor_changed(diff: int) -> void:
	armor_bar.change_max_value(armor.get_max_armor())


func _on_player_weapon_dropped(index: int) -> void:
	inventory.get_child(index).queue_free()


func _on_player_weapon_picked_up(weapon_stats: WeaponStats) -> void:
	var new_weapon: PanelContainer = INVENTORY_ITEM_SCENE.instantiate()
	inventory.add_child(new_weapon)
	new_weapon.initialize(weapon_stats)


func _on_player_weapon_switched(prev_index: int, new_index: int) -> void:
	inventory.get_child(prev_index).deselect()
	inventory.get_child(new_index).select()


func _on_player_armor_equipped(armor_item: ArmorItem) -> void:
	if armor_item != null:
		armor_inventory.initialize(armor_item.armor_stats)

func play_bgm():
	var bgm_num = rng.randi_range(2,6)
	curr_bgm_name = "bgm_" + str(bgm_num)
	SoundManager.fade_in_bgm(curr_bgm_name, 2)
