extends State
class_name EnemyState

var target: Enemy

func _ready() -> void:
	await owner.ready
	target = owner as Enemy
	assert(target != null, "EnemyState requires an Enemy node as its owner.")
