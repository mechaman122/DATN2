extends VBoxContainer

@onready var interface = get_parent()
var OptionSlot = preload("res://interface/upgrade_slot.tscn")

func _ready() -> void:
	hide()
	

func close_option():
	hide()
	get_tree().paused = false


func show_option():
	for slot in get_children():
		slot.queue_free()
	var current_weapon = interface.player.current_weapon
	var option_size = 0
	if current_weapon.is_upgradable():
		var option_slot = OptionSlot.instantiate()
		option_slot.weapon = current_weapon
		add_child(option_slot)
		option_size += 1
		
	if option_size == 0:
		return
	
	show()
	get_tree().paused = true
