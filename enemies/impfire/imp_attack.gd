extends ImpState

@export var speed := 40.0
var player: CharacterBody2D
var knockback_direction = Vector2()

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	imp.attack_cooldown_timer.start()
	imp.animation_player.play("attack")

func physics_update(delta: float) -> void:
	var dir = player.global_position - imp.global_position
	if dir.x < 0:
		imp.animated_sprite.flip_h = true
	if dir.x > 0:
		imp.animated_sprite.flip_h = false


func _on_attack_cooldown_timer_timeout() -> void:
	var dir = player.global_position - imp.global_position
	finished.emit(FIRE)
	if dir.length() > 80:
		finished.emit(CHASE)
	if dir.length() < 80:
		finished.emit(IDLE)
	if imp.health_changed:
		finished.emit(HURT)
	if imp.health.health <= 0:
		finished.emit(DIE)
