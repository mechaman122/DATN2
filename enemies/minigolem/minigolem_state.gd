class_name MiniGolemState extends State

const IDLE = "Idle"
const CHASE = "Chase"
const ATK = "Attack"
const DIE = "Die"

var minigolem: MiniGolem

func _ready() -> void:
	await owner.ready
	minigolem = owner as MiniGolem
	assert(minigolem != null, "MiniGolemState requires a MiniGolem node as its owner.")
