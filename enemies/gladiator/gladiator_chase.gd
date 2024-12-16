extends GladiatorState

@export var speed := 40.0
var player: CharacterBody2D

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	gladiator.animation_player.play("chase")

func physics_update(delta: float) -> void:
	gladiator.navigation2d.target_position = player.global_position
	
	var curr_agent_position = gladiator.global_position
	var next_path_position = gladiator.navigation2d.get_next_path_position()
	var new_velocity = curr_agent_position.direction_to(next_path_position) * speed
	
	if gladiator.navigation2d.avoidance_enabled:
		gladiator.navigation2d.set_velocity(new_velocity)
	else:
		_on_navigation_agent_2d_velocity_computed(new_velocity)
	gladiator.move_and_slide()
	var dir = player.global_position - gladiator.global_position
	
	if dir.length() <= 15:
		gladiator.velocity = Vector2.ZERO
		finished.emit(ATK)
	if gladiator.health_changed:
		finished.emit(HURT)
	if gladiator.health.health == 0:
		finished.emit(DIE)
	#if dir.length() > 20:
		#finished.emit(IDLE)


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	gladiator.velocity = safe_velocity
