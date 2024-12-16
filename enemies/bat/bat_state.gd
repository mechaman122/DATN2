class_name BatState extends State

const IDLE = "Idle"
const CHASE1 = "Chase1"
const ATK = "Attack"
const HURT = "Hurt"
const DIE = "Die"
const RESET = "Reset"
var bat: Bat

func _ready() -> void:
	await owner.ready
	bat = owner as Bat
	assert(bat != null, "BatState requires a Bat node as its owner.")
