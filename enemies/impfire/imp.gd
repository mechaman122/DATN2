extends Enemy
class_name Imp

@onready var timer = get_node("Timer")
@onready var hurt = get_node("HurtTimer")
@onready var fire = get_node("FireCD")

func _ready() -> void:
	health.max_health = 10
	health.health = 10
