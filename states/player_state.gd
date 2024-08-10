class_name PlayerState extends State

const IDLE = "Idle"
const RUN = "Run"
const MELEE = "Melee"
const DIE = "Die"

var player: Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "PlayerState requires a Player node as its owner.")
