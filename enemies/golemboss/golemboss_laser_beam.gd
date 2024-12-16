extends GolemBossState

@onready var pivot = $"../../Pivot"
@onready var pivotsprite = $"../../Pivot/Sprite2D"
var can_transition: bool = false

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	await play_animation("laser_cast")
	await play_animation("laser")
	can_transition = true

func set_target():
	var dir = (player.global_position - golemboss.global_position).normalized()
	pivot.rotation = dir.angle()
	golemboss.laser.rotation = dir.angle()
	if dir.x < 0:
		pivotsprite.flip_v = true
	else:
		pivotsprite.flip_v = false
	
func play_animation(anim_name):
	golemboss.animation_player.play(anim_name)
	await golemboss.animation_player.animation_finished

func physics_update(delta: float) -> void:
	if can_transition:
		can_transition = false
		finished.emit(DASH)
	elif golemboss.health.health <= 0:
		finished.emit(DEATH)
