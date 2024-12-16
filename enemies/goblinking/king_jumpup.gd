extends GoblinKingState

@export var speed := 40.0
var player: CharacterBody2D
var knockback_direction = Vector2()


func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	goblinking.animation_player.play("jumpup")
	goblinking.attack_cooldown_timer.start()

func _on_attack_cooldown_timer_timeout() -> void:
	goblinking.global_position = player.global_position
	goblinking.velocity = Vector2.ZERO
	finished.emit(JD)
