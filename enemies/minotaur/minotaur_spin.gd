extends MinotaurState

@export var speed := 40.0
var player: CharacterBody2D
var direction
var spin = false

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	minotaur.attack_cooldown_timer.start()
	minotaur.timer.start()
	minotaur.animation_player.play("spin")

func physics_update(delta: float) -> void:
	var dir = player.global_position - minotaur.global_position
	
	if spin:
		minotaur.velocity = direction.normalized() * 160
	else:
		minotaur.velocity = Vector2() * 0
	#if dir.length() > 75:
		#finished.emit(IDLE)


func _on_attack_cooldown_timer_timeout() -> void:
	spin = false
	finished.emit(IDLE)

func _on_timer_timeout() -> void:
	spin = true
	direction = player.global_position - minotaur.global_position
