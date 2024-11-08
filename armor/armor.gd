extends Node2D

class_name Armor

signal max_armor_changed(diff: int)
signal armor_changed(diff: int)

@export var max_armor: int = 10: set = set_max_armor, get = get_max_armor
@export var armor: int: set = set_armor, get = get_armor

@onready var cooldown_timer: Timer = get_node("CooldownTimer")
@onready var recharge_timer: Timer = get_node("RechargeTimer")


func set_max_armor(value: int):
	var clamp_value = max(1, value)

	if clamp_value != max_armor:
		var difference = clamp_value - max_armor
		max_armor = clamp_value
		emit_signal("max_armor_changed", difference)
		
		if get_parent() is Player:
			SavedData.max_armor = value
		if armor >= max_armor:
			armor = max_armor
		else:
			set_armor(armor)
	
func get_max_armor() -> int:
	return max_armor


func set_armor(value: int):
	var clamp_value = clamp(value, 0, max_armor)

	if clamp_value != armor:
		var difference = clamp_value - armor
		armor = value
		if difference < 0:
			cooldown_timer.start()
			recharge_timer.stop()
		emit_signal("armor_changed", difference)
		print(armor)
	
	
func get_armor() -> int:
	return armor


func _ready() -> void:
	set_max_armor(max_armor)
	set_armor(armor)
	

func _on_cooldown_timer_timeout() -> void:
	armor += 1
	emit_signal("armor_changed", 1)
	recharge_timer.start()


func _on_recharge_timer_timeout() -> void:
	if armor < max_armor:
		armor += 1
		emit_signal("armor_changed", 1)
		recharge_timer.start()
