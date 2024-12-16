class_name ImpState extends State

const IDLE = "Idle"
const CHASE = "Chase"
const ATK = "Attack"
const FIRE = "Fire"
const HURT = "Hurt"
const DIE = "Die"

var imp: Imp

func _ready() -> void:
	await owner.ready
	imp = owner as Imp
	assert(imp != null, "ImpState requires a Imp node as its owner.")
