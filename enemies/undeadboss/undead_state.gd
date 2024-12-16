extends State
class_name UndeadBossState

const IDLE = "Idle"
const FOLLOW = "Follow"
const ATK = "Attack"
const TELE = "Teleport"
const SPAWN = "SpawnMinion"
const DEATH = "Death"

var speed: int = 80
var player: CharacterBody2D
var undead: UndeadBoss

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	await owner.ready
	undead = owner as UndeadBoss
	assert(undead != null, "UndeadBossState requires a UndeadBoss node as its owner.")
