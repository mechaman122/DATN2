extends GoblinKingState

@export var speed := 40.0
var player: CharacterBody2D
var knockback_direction = Vector2()
var fliph = false

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	goblinking.animation_player.play("attack1")
	goblinking.melee.start()


func physics_update(delta: float) -> void:
	var dir = player.global_position - goblinking.global_position
	if dir.x < 0:
		goblinking.animated_sprite.flip_h = true
		goblinking.hitbox.position = Vector2(-12, 0)
	if dir.x > 0:
		goblinking.hitbox.position = Vector2(12, 0)
		goblinking.animated_sprite.flip_h = false

	if goblinking.health_changed:
		finished.emit(HURT)
	if goblinking.health.health <= 0:
		finished.emit(DIE)

func _on_melee_cd_timeout() -> void:
	finished.emit(CHASE)
