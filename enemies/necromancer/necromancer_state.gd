class_name NecromancerState extends State

const IDLE = "Idle"
const CHASE = "Chase"
const SUM = "Summon"
const DIE = "Die"

var necromancer: Necromancer

func _ready() -> void:
	await owner.ready
	necromancer = owner as Necromancer
	assert(necromancer != null, "NecromancerState requires a Necromancer node as its owner.")
