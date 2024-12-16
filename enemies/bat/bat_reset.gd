extends BatState
var speed = 40
var player = CharacterBody2D

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")


func physics_update(delta: float) -> void:
	bat.navigation2d.target_position = bat.init_pos
	var curr_agent_position = bat.global_position
	var next_path_position = bat.navigation2d.get_next_path_position()
	var new_velocity = curr_agent_position.direction_to(next_path_position) * speed
	if bat.navigation2d.avoidance_enabled:
		bat.navigation2d.set_velocity(new_velocity)
	else:
		bat.velocity = new_velocity
	bat.move_and_slide()
	bat.health.health = bat.health.max_health
	if (bat.global_position - bat.init_pos).length() <= sqrt(2.0):
		finished.emit(IDLE)
	if bat.health.health <= 0:
		finished.emit(DIE)
