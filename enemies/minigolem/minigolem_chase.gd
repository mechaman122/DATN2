extends MiniGolemState

@export var speed := 40.0
var player: CharacterBody2D

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	minigolem.animation_player.play("chase")

func physics_update(delta: float) -> void:
	var dir = player.global_position - minigolem.global_position
	
	if dir.length() > 12.5:
		minigolem.velocity = dir.normalized() * speed
	else: 
		finished.emit(ATK)
		minigolem.velocity = Vector2()
	#if minigolem.health.health == 0:
		#finished.emit(DIE)
	#if dir.length() > 75:
		#finished.emit(IDLE)