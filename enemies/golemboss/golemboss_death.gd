extends GolemBossState

var STAIR = preload("res://map/map_elements/stairs.tscn")
var TREASURE = preload("res://map/map_elements/treasure.tscn")

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	golemboss.animation_player.play("death")
	await golemboss.animation_player.animation_finished
	golemboss.animation_player.play("boss_slained")
	await golemboss.animation_player.animation_finished
	drop_item()
	
	
func drop_item():
	var item = TREASURE.instantiate()
	var stair = STAIR.instantiate()
	item.global_position = golemboss.global_position
	stair.position = golemboss.global_position + Vector2(0, 30)
	golemboss.get_parent().call_deferred("add_child", item)
	golemboss.get_parent().call_deferred("add_child", stair)
