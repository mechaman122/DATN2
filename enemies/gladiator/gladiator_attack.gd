extends GladiatorState

@export var speed := 40.0
var player: CharacterBody2D
var knockback_direction = Vector2()

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	gladiator.animation_player.play("attack")
	if gladiator.animated_sprite.flip_h == false:
		gladiator.gladiator_hitbox.position = Vector2(12.5, -10)
	else:
		gladiator.gladiator_hitbox.position = Vector2(-12.5, -10)

func physics_update(delta: float) -> void:
	var dir = player.global_position - gladiator.global_position
	#if dir.length() > 15:
		#gladiator.velocity = dir.normalized() * speed
	#else: 
		#gladiator.velocity = Vector2()
	#
	if dir.length() > 12.5:
		finished.emit(CHASE)
	if dir.length() > 75:
		finished.emit(IDLE)

func _on_hitbox_body_entered(hurtbox: Hurtbox) -> void:
	print(hurtbox)
