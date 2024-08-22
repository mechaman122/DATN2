class_name Health
extends Node

signal max_health_changed(diff: int)
signal health_changed(diff: int)
signal health_depleted

@export var max_health: int = 10: set = set_max_health, get = get_max_health
@export var immortality: bool = false: set = set_immortality, get = get_immortality

var immortality_timer: Timer = null

@export var health: int = max_health: set = set_health, get = get_health

func set_max_health(value: int):
	var clamp_value = max(1, value)

	if clamp_value != max_health:
		var difference = clamp_value - max_health
		max_health = value
		emit_signal("max_health_changed", difference)

		if health > max_health:
			health = max_health

func get_max_health() -> int:
	return max_health

func set_health(value: int):
	if value < health and immortality:
		return

	var clamp_value = clamp(value, 0, max_health)

	if clamp_value != health:
		var difference = clamp_value - health
		health = value
		emit_signal("health_changed", difference)

		if health == 0:
			emit_signal("health_depleted")

func get_health() -> int:
	return health

func set_immortality(value: bool):
	pass

func get_immortality() -> bool:
	return immortality
