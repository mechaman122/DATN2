extends GladiatorState

@export var speed := 40.0
var player: CharacterBody2D

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	gladiator.animation_player.play("chase")

func physics_update(delta: float) -> void:
	var dir = player.global_position - gladiator.global_position
	
	if dir.length() > 12.5:
		gladiator.velocity = dir.normalized() * speed
	else: 
		finished.emit(ATK)
		gladiator.velocity = Vector2()
	
	if dir.length() > 75:
		finished.emit(IDLE)
