extends GolemBossState

@export var bullet_node: PackedScene
var can_transition: bool = false

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	golemboss.animation_player.play("ranged_attack")
	await golemboss.animation_player.animation_finished
	shoot()
	can_transition = true

func shoot():
	var bullet = bullet_node.instantiate()
	bullet.position = owner.position
	get_tree().current_scene.add_child(bullet)
#
func physics_update(delta: float) -> void:
	
	if can_transition:
		can_transition = false
		finished.emit(DASH)
	elif golemboss.health.health <= 0:
		finished.emit(DEATH)
