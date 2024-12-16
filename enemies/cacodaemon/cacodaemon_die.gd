extends CacodaemonState

var coin := preload("res://collectibles/list/coin.tscn")
var dead = false

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	#player = get_tree().get_first_node_in_group("Adventurer")
	cacodaemon.animation_player.play("die")
	dead = true

func physics_update(delta: float) -> void:
	cacodaemon.velocity = Vector2()
	if dead:
		drop_item()
	
func drop_item():
	var item = coin.instantiate()
	item.global_position = cacodaemon.global_position
	cacodaemon.get_parent().call_deferred("add_child", item)
	dead = false