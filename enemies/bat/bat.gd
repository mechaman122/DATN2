extends Enemy
class_name Bat

@onready var timer = $Timer

func _ready() -> void:
	
	health.max_health = 10
	health.health = 10
