extends GladiatorState

@export var speed := 40.0
var player: CharacterBody2D
var knockback_direction = Vector2()

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	gladiator.animation_player.play("attack")
	gladiator.attack_cooldown_timer.start()

func physics_update(delta: float) -> void:
	var dir = player.global_position - gladiator.global_position
	if dir.x < 0:
		gladiator.animated_sprite.flip_h = true
		gladiator.hitbox.position = Vector2(-12.5, -10)
	if dir.x > 0:
		gladiator.hitbox.position = Vector2(12.5, -10)
		gladiator.animated_sprite.flip_h = false

	if gladiator.health.health == 0:
		finished.emit(DIE)
	if gladiator.health_changed:
		finished.emit(HURT)
	#if dir.length() > 75:
		#finished.emit(IDLE)

func _on_attack_cooldown_timer_timeout() -> void:
	finished.emit(CHASE)
