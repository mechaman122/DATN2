extends BeeState

@onready var timer = $Timer

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	timer.start()

func physics_update(delta: float) -> void:
	var dir = player.global_position - bee.global_position
	if dir.length() <= 100:
		bee.velocity = Vector2.ZERO
		finished.emit(SHOOT)
	elif bee.health.health <= 0 :
		finished.emit(DEATH)


func dash():
	var tween = get_tree().create_tween()
	tween.tween_property(owner, "position", player.position, 0.75)
	await tween.finished

func _on_timer_timeout() -> void:
	dash()
