extends UndeadBossState
 
var STAIR = preload("res://map/map_elements/stairs.tscn")
var TREASURE = preload("res://map/map_elements/treasure.tscn")

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	undead.animation_player.play("death")
	await undead.animation_player.animation_finished
	undead.animation_player.play("boss_slained")
	await undead.animation_player.animation_finished
	drop_item()
	
	
func drop_item():
	var item = TREASURE.instantiate()
	var stair = STAIR.instantiate()
	item.global_position = undead.global_position
	stair.position = undead.global_position + Vector2(0, 30)
	undead.get_parent().call_deferred("add_child", item)
	undead.get_parent().call_deferred("add_child", stair)
