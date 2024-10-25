class_name GladiatorState extends State

const IDLE = "Gladiator_idle"
const CHASE = "Gladiator_chase"
const ATK = "Gladiator_attack"

var gladiator: Gladiator
var chase = false
func _ready() -> void:
	await owner.ready
	gladiator = owner as Gladiator
	assert(gladiator != null, "GladiatorState requires a Gladiator node as its owner.")
