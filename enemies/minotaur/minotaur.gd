extends Enemy
class_name Minotaur 

@onready var timer = get_node("Timer")


func _ready() -> void:
	health.max_health = 10
	health.health = 10
