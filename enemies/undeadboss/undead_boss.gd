extends Enemy
class_name UndeadBoss

@onready var sprite = $Sprite2D
@onready var progress_bar = $UI/ProgressBar
@onready var hitbox2 = $Attack2/CollisionShape2D

func _ready() -> void:
	health.max_health = 100
	health.health = 3
#
func _process(delta: float) -> void:
	progress_bar.value = health.health
