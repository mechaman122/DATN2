extends Enemy
class_name GolemBoss

@onready var sprite = $Sprite2D
@onready var progress_bar = $UI/ProgressBar
@onready var laser = $Laser/CollisionShape2D

func _ready() -> void:
	health.max_health = 100
	health.health = 3
	boss = true
#
func _process(delta: float) -> void:
	progress_bar.value = health.health
