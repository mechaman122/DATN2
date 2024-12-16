extends GolemBossState

var can_transition: bool = false

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	await dash()
	can_transition = true
	golemboss.animation_player.play("glowing")

func physics_update(delta: float) -> void:
	if can_transition:
		can_transition = false
		finished.emit(FOLLOW)
	elif golemboss.health.health <= 0:
		finished.emit(DEATH)


func dash():
	var tween = create_tween()
	tween.tween_property(owner, "position", player.position, 0.8)
	await tween.finished
