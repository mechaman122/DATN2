extends BatState

@export var speed := 10.0

var mov_direction: Vector2
var wander_time: float
var player: CharacterBody2D

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	bat.animation_player.play("chase1")	
	bat.velocity = Vector2.ZERO
	#bat.velocity = Vector2()
	#randomize_wander()
#
#func update(delta: float):
	#if wander_time > 0:
		#wander_time -= delta
	#
	#else: 
		#randomize_wander()

func physics_update(delta: float) -> void:
	var dir = player.global_position - bat.global_position
	if dir.length() <= 100 :
		finished.emit(CHASE1)
	if bat.health.health <= 0:
		finished.emit(DIE)
	#if bat.health_changed:
		#finished.emit(HURT)
	#if bat.health.health <= 0:
		#finished.emit(DIE)
