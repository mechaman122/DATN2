extends MinotaurState

@export var speed := 10.0

var mov_direction: Vector2
var wander_time: float
var player: CharacterBody2D

func randomize_wander():
	mov_direction = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
	wander_time = randf_range(1,3)

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	minotaur.animation_player.play("idle")
	#goblinking.velocity = Vector2()
	#randomize_wander()

#func update(delta: float):
	#if wander_time > 0:
		#wander_time -= delta
	#
	#else: 
		#randomize_wander()

func physics_update(delta: float) -> void:
	#minotaur.velocity = mov_direction * speed
	var dir = player.global_position - minotaur.global_position
	if dir.length() > 0 :
		finished.emit(CHASE)
	#if gladiator.health.health == 0:
		#finished.emit(DIE)
	if dir.length() > 120:
		finished.emit(SPIN)
