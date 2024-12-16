extends MiniGolemState

@export var speed := 40.0
var player: CharacterBody2D
var knockback_direction = Vector2()
var fliph = false

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	minigolem.animation_player.play("attack")
	if minigolem.animated_sprite.flip_h == false:
		fliph = false
		minigolem.hitbox.position = Vector2(12.5, -10)
	else:
		fliph = true
		minigolem.hitbox.position = Vector2(-12.5, -10)

func physics_update(delta: float) -> void:
	var dir = player.global_position - minigolem.global_position
	if fliph:
		minigolem.animated_sprite.flip_h = true
	else:
		minigolem.animated_sprite.flip_h = false
	#if dir.length() > 15:
		#gladiator.velocity = dir.normalized() * speed
	#else: 
		#gladiator.velocity = Vector2()
	#
	#if minigolem.health.health == 0:
		#finished.emit(DIE)
	if dir.length() > 12.5:
		finished.emit(CHASE)
	if dir.length() > 75:
		finished.emit(IDLE)

func _on_hitbox_body_entered(hurtbox: Hurtbox) -> void:
	print(hurtbox)
