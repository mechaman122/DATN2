extends Enemy
class_name Gladiator 

@onready var hurt_timer = $Hurt_timer
func _ready() -> void:
	health.max_health = 10
	health.health = 10
