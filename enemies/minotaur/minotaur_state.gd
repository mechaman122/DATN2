class_name MinotaurState extends State

const IDLE = "Idle"
const CHASE = "Chase"
const ATK = "Attack"
const SPIN = "Spin"
const HURT = "Hurt"
const DIE = "Die"

var minotaur: Minotaur

func _ready() -> void:
	await owner.ready
	minotaur = owner as Minotaur
	assert(minotaur != null, "MinotaurState requires a Minotaur node as its owner.")
