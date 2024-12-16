class_name GladiatorState extends State

const IDLE = "Idle"
const CHASE = "Chase"
const ATK = "Attack"
const HURT = "Hurt"
const DIE = "Die"

var gladiator: Gladiator

func _ready() -> void:
	await owner.ready
	gladiator = owner as Gladiator
	assert(gladiator != null, "GladiatorState requires a Gladiator node as its owner.")
