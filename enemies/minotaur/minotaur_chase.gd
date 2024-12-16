extends MinotaurState

@export var speed := 40.0
var player: CharacterBody2D

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	minotaur.animation_player.play("chase")

func physics_update(delta: float) -> void:
	var dir = player.global_position - minotaur.global_position
	minotaur.velocity = dir.normalized() * speed
	if dir.length() <= 30:
		minotaur.velocity = Vector2()
		finished.emit(ATK)
	if minotaur.health_changed:
		finished.emit(HURT)
	if minotaur.health.health == 0:
		finished.emit(DIE)
	if dir.length() > 120:
		finished.emit(IDLE)
#
#
#func _on_attack_cd_timeout() -> void:
	#finished.emit(ATK)
