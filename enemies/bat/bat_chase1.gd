extends BatState

@export var speed := 40.0
var player: CharacterBody2D
var touch = false
var curr_agent_position
var next_path_position
var new_velocity

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	bat.animation_player.play("chase1")

func physics_update(delta: float) -> void:
	var dir = player.global_position - bat.global_position
	#if dir.length() > 100:
		#finished.emit(IDLE)
	if bat.health_changed:
		finished.emit(HURT)
	if bat.health.health <= 0:
		finished.emit(DIE)
	if dir.length() <= 10:
		bat.velocity = Vector2.ZERO
		finished.emit(ATK)
	if not (2*bat.global_position.x <= (2*bat.active_center.x + bat.active_size.x) && 2*bat.global_position.x >= (2*bat.active_center.x - bat.active_size.x) && 2*bat.global_position.y <= (2*bat.active_center.y + bat.active_size.y) && 2*bat.global_position.y >= (2*bat.active_center.y - bat.active_size.y)):
		print((bat.global_position - bat.active_center).length())
		#bat.navigation2d.target_position = bat.init_pos
		finished.emit(RESET)
	else:
		bat.navigation2d.target_position = player.global_position
	
	curr_agent_position = bat.global_position
	next_path_position = bat.navigation2d.get_next_path_position()
	new_velocity = curr_agent_position.direction_to(next_path_position) * speed
	
	if bat.navigation2d.avoidance_enabled:
		bat.navigation2d.set_velocity(new_velocity)
	else:
		_on_navigation_agent_2d_velocity_computed(new_velocity)
	bat.move_and_slide()
func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	bat.velocity = safe_velocity
