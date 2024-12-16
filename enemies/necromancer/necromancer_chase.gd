extends NecromancerState

@export var speed := 40.0
var player: CharacterBody2D

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	necromancer.animation_player.play("chase")

func physics_update(delta: float) -> void:
	var dir = player.global_position - necromancer.global_position
	necromancer.velocity = dir.normalized() * speed
	if dir.length() < 100:
		necromancer.velocity = Vector2.ZERO
		finished.emit(IDLE)
	#elif dir.length() < 100:
		#finished.emit(IDLE)


func _on_attack_cooldown_timer_timeout() -> void:
	finished.emit(SUM)
