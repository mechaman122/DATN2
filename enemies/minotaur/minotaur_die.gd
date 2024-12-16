extends MinotaurState

var treasure := preload("res://map/map_elements/treasure.tscn")
var dead = false

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	#player = get_tree().get_first_node_in_group("Adventurer")
	minotaur.animation_player.play("die")
	dead = true

func physics_update(delta: float) -> void:
	minotaur.velocity = Vector2()
	if dead:
		drop_item()
	
func drop_item():
	var item = treasure.instantiate()
	item.global_position = minotaur.global_position
	minotaur.get_parent().call_deferred("add_child", item)
	dead = false
