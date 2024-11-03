extends CanvasLayer

const INVENTORY_ITEM_SCENE: PackedScene = preload("res://inventory/inventory_item.tscn")

@onready var health_bar = $HealthBar
@onready var health = get_parent().get_node("Adventurer/Health")

@onready var armor_bar = $ArmorBar
@onready var armor = get_parent().get_node("Adventurer/Armor")

@onready var inventory: HBoxContainer = get_node("PanelContainer/Inventory")
@onready var level_label: Label = get_node("LevelLabel")
@onready var player = get_parent().get_node("Adventurer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_label.text = "Floor " + str(SavedData.level)
	
	health.max_health_changed.connect(_on_max_health_changed)
	health.health_changed.connect(_on_health_changed)

	armor.max_armor_changed.connect(_on_max_armor_changed)
	armor.armor_changed.connect(_on_armor_changed)


func _on_health_changed(diff: int) -> void:
	health_bar.change_value(health.get_health(), health.get_max_health())
	if diff < 0:
		player.health_changed = true


func _on_max_health_changed(diff: int) -> void:
	health_bar.change_max_value(health.get_health(), health.get_max_health())


func _on_armor_changed(diff: int) -> void:
	armor_bar.change_value(armor.get_armor(), armor.get_max_armor())
	

func _on_max_armor_changed(diff: int) -> void:
	armor_bar.change_max_value(armor.get_armor(), armor.get_max_health())


func _on_player_weapon_dropped(index: int) -> void:
	inventory.get_child(index).queue_free()


func _on_player_weapon_picked_up(weapon_stats: WeaponStats) -> void:
	var new_weapon: PanelContainer = INVENTORY_ITEM_SCENE.instantiate()
	inventory.add_child(new_weapon)
	new_weapon.initialize(weapon_stats)


func _on_player_weapon_switched(prev_index: int, new_index: int) -> void:
	inventory.get_child(prev_index).deselect()
	inventory.get_child(new_index).select()
