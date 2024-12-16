extends BatState

var player: CharacterBody2D

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	bat.attack_cooldown_timer.start()
	bat.hitbox.disabled = false

func _on_attack_cooldown_timer_timeout() -> void:
	bat.hitbox.disabled = true
	print(bat.hitbox.disabled)
	finished.emit(CHASE1)
