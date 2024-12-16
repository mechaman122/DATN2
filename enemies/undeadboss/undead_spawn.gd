extends UndeadBossState
 
@export var minion_node : PackedScene
var can_transition: bool = false
 
func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	undead.animation_player.play("summon")
	await undead.animation_player.animation_finished
	can_transition = true
 
func spawn():
	var minion = minion_node.instantiate()
	minion.position = undead.position + Vector2(40,-40)
	get_tree().current_scene.add_child(minion)

func physics_update(delta: float) -> void:
	if can_transition:
		can_transition = false
		finished.emit(FOLLOW)
	if undead.health.health <= 0:
		finished.emit(DEATH)
