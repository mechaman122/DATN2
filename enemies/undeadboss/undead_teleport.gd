extends UndeadBossState
 
var can_transition: bool = false
var tele = [Vector2.RIGHT, Vector2.LEFT] 

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	undead.animation_player.play("skill")
	await undead.animation_player.animation_finished
	can_transition = true
 
func teleport():
	undead.position = player.position + tele[randi_range(0,1)] * 40
 
func physics_update(delta: float) -> void:
	if can_transition:
		can_transition = false
		finished.emit(ATK)
	if undead.health.health <= 0:
		finished.emit(DEATH)
