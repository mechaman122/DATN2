extends Enemy
class_name GoblinKing 

@onready var melee = get_node("MeleeCD")
@onready var jump = get_node("JumpCD")
@onready var after = get_node("AfterJD")
@onready var timer = get_node("Timer")

func _ready() -> void:
	health.max_health = 10
	health.health = 10
