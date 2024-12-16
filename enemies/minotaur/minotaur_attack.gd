extends MinotaurState

@export var speed := 40.0
var player: CharacterBody2D
var knockback_direction = Vector2()
var fliph = false

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	minotaur.animation_player.play("attack")
	if minotaur.animated_sprite.flip_h == false:
		fliph = false
		minotaur.hitbox.position = Vector2(35, -20)
	else:
		fliph = true
		minotaur.hitbox.position = Vector2(-35, -20)

func physics_update(delta: float) -> void:
	var dir = player.global_position - minotaur.global_position
	if fliph:
		minotaur.animated_sprite.flip_h = true
	else:
		minotaur.animated_sprite.flip_h = false
	#if dir.length() > 15:
		#gladiator.velocity = dir.normalized() * speed
	#else: 
		#gladiator.velocity = Vector2()
	#
	if dir.length() > 50:
		finished.emit(CHASE)
	if dir.length() > 120:
		finished.emit(IDLE)

func _on_hitbox_body_entered(hurtbox: Hurtbox) -> void:
	print(hurtbox)
