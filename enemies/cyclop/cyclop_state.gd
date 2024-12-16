class_name CyclopState extends State

const IDLE = "Idle"
const CHASE = "Chase"
const ATK1 = "Attack1"
const ROCK = "Attack_rock"
const LASER = "Attack_laser"
const HURT = "Hurt"
const DIE = "Die"

var cyclop: Cyclop

func _ready() -> void:
	await owner.ready
	cyclop = owner as Cyclop
	assert(cyclop != null, "CyclopState requires a Cyclop node as its owner.")
