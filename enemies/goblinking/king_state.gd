class_name GoblinKingState extends State

const IDLE = "Idle"
const CHASE = "Chase"
const ATK = "Attack"
const JU = "JumpUp"
const JD = "JumpDown"
const HURT = "Hurt"
const DIE = "Die"

var goblinking: GoblinKing

func _ready() -> void:
	await owner.ready
	goblinking = owner as GoblinKing
	assert(goblinking != null, "GoblinKingState requires a GoblinKing node as its owner.")
