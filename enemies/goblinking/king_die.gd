extends GoblinKingState

var treasure := preload("res://map/map_elements/treasure.tscn")
var dead = false

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	#player = get_tree().get_first_node_in_group("Adventurer")
	goblinking.animation_player.play("die")
	dead = true

func physics_update(delta: float) -> void:
	goblinking.velocity = Vector2()
	if dead:
		drop_item()
	
func drop_item():
	var item = treasure.instantiate()
	item.global_position = goblinking.global_position
	goblinking.get_parent().call_deferred("add_child", item)
	dead = false
