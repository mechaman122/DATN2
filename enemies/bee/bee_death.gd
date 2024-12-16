extends BeeState

var coin := preload("res://collectibles/list/coin.tscn")
var dead = false

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	#player = get_tree().get_first_node_in_group("Adventurer")
	bee.animation_player.play("die")
	dead = true

func physics_update(delta: float) -> void:
	bee.velocity = Vector2()
	if dead:
		drop_item()
	
func drop_item():
	var item = coin.instantiate()
	item.global_position = bee.global_position
	bee.get_parent().call_deferred("add_child", item)
	dead = false
