extends CacodaemonState

@export var speed := 40.0
var player: CharacterBody2D

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	cacodaemon.animation_player.play("chase")

func physics_update(delta: float) -> void:
	var dir = player.global_position - cacodaemon.global_position
	cacodaemon.velocity = dir.normalized() * speed
	if cacodaemon.health_changed:
		finished.emit(HURT)
	if cacodaemon.health.health == 0:
		finished.emit(DIE)
