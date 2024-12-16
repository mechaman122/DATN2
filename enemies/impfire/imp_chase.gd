extends ImpState

@export var speed := 40.0
var player: CharacterBody2D

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	imp.animation_player.play("chase")

func physics_update(delta: float) -> void:
	var dir = player.global_position - imp.global_position
	#imp.velocity = imp.global_position + dir * 10
	if dir.length() > 80:
		imp.velocity = dir.normalized() * speed
	if dir.length() < 80 && dir.length() > 60:
		finished.emit(IDLE)
	if dir.length() < 60:
		imp.velocity = dir.normalized() * speed * -1
	if imp.health_changed:
		finished.emit(HURT)
	if imp.health.health <= 0:
		finished.emit(DIE)

func _on_fire_cd_timeout() -> void:
	finished.emit(ATK)
