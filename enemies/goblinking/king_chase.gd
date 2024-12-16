extends GoblinKingState

@export var speed := 20.0
var player: CharacterBody2D


func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	goblinking.animation_player.play("chase")

func physics_update(delta: float) -> void:
	var dir = player.global_position - goblinking.global_position
	goblinking.velocity = dir.normalized() * speed

	if dir.length() <= 20:
		goblinking.velocity = Vector2.ZERO
		finished.emit(ATK)
	if goblinking.health_changed:
		finished.emit(HURT)
	if goblinking.health.health == 0:
		finished.emit(DIE)

func _on_jump_cd_timeout() -> void:
	goblinking.velocity = Vector2.ZERO
	finished.emit(JU)
