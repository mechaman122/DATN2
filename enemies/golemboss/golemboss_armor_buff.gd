extends GolemBossState

var can_transition : bool = false

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	golemboss.animation_player.play("armor_buff")
	await golemboss.animation_player.animation_finished
	can_transition = true
	print(golemboss.armorbuff)
	
func physics_update(delta: float) -> void:
	if can_transition:
		can_transition = false
		finished.emit(FOLLOW)
	elif golemboss.health.health <= 0:
		finished.emit(DEATH)
