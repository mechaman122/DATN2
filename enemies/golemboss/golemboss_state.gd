extends State
class_name GolemBossState

const IDLE = "Idle"
const FOLLOW = "Follow"
const MELEE = "MeleeAttack"
const HOMING = "HomingMissile"
const LASER = "LaserBeam"
const ARMOR = "ArmorBuff"
const DASH = "Dash"
const DEATH = "Death"

var speed: int = 60
var player: CharacterBody2D
var golemboss: GolemBoss

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	await owner.ready
	golemboss = owner as GolemBoss
	assert(golemboss != null, "GolemBossState requires a GolemBoss node as its owner.")
