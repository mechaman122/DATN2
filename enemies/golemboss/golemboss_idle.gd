extends GolemBossState

@onready var collision = $"../../PlayerDetection/CollisionShape2D"
@onready var progress_bar = owner.find_child("ProgressBar")

var player_entered: bool = false:
	set(value):
		player_entered = value
		collision.set_deferred("disabled", value)
		progress_bar.set_deferred("visible",value)
		

func physics_update(delta: float) -> void:
	#var dir = player.global_position - golemboss.global_position
	if player_entered:
		finished.emit(FOLLOW)
	if golemboss.health.health <= 0:
		finished.emit(DEATH)

func _on_player_detection_body_entered(body: Node2D) -> void:
	player_entered = true
