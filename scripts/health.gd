class_name Health
extends Node2D

signal max_health_changed(diff: int)
signal health_changed(diff: int)
signal health_depleted

@export var max_health: int = 10: set = set_max_health, get = get_max_health
@export var immortality: bool = false: set = set_immortality, get = get_immortality
@export var armor: Armor

var immortality_timer: Timer = null

@export var health: int = 1: set = set_health, get = get_health

func _ready():
	set_max_health(max_health)
	set_health(health)

func set_max_health(value: int):
	var clamp_value = max(1, value)

	if clamp_value != max_health:
		var difference = clamp_value - max_health
		max_health = clamp_value
		emit_signal("max_health_changed", difference)
		
		if get_parent() is Player:
			SavedData.max_health = value
		if health > max_health:
			health = max_health
			if get_parent() is Player:
				SavedData.health = value
			

func get_max_health() -> int:
	return max_health

func set_health(value: int):
	if value < health and immortality:
		return

	var clamp_value = clamp(value, 0, max_health)

	if clamp_value != health:
		var difference = clamp_value - health
		health = value
		if get_parent() is Player:
			SavedData.health = value
		emit_signal("health_changed", difference)

		if health == 0:
			emit_signal("health_depleted")

func get_health() -> int:
	return health

func set_immortality(value: bool):
	immortality = value

func get_immortality() -> bool:
	return immortality

func set_temp_immortality(time: float):
	if immortality_timer == null:
		immortality_timer = Timer.new()
		immortality_timer.one_shot = true
		add_child(immortality_timer)

	if immortality_timer.timeout.is_connected(set_immortality):
		immortality_timer.timeout.disconnect(set_immortality)

	immortality_timer.set_wait_time(time)
	immortality_timer.timeout.connect(set_immortality.bind(false))
	immortality = true
	immortality_timer.start()
