extends GoblinKingState

@export var speed := 40.0
var player: CharacterBody2D
var knockback_direction = Vector2()


func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	goblinking.animation_player.play("jumpdown")
	goblinking.after.start()
	goblinking.timer.start()
	##var direction = (goblinking.global_position + Vector2(1,1)) * -1
	##var force = direction
	#player.knockback = goblinking.global_position 
#
	#player.velocity = player.knockback * 10
	#player.move_and_slide()
	#player.knockback = player.knockback.lerp(Vector2.ZERO, 0.1)

func _on_after_jd_timeout() -> void:
	finished.emit(CHASE)

func _on_timer_timeout() -> void:
	player.knockback = goblinking.global_position 
	player.velocity = player.knockback * 20
	player.move_and_slide()
	player.knockback = player.knockback.lerp(Vector2.ZERO, 0.1)
