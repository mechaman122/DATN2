extends State
class_name BeeState

const IDLE = "Idle"
const FOLLOW = "Follow"
const SHOOT = "Shoot"
const DASH = "Dash"
const DEATH = "Death"

var speed = 25
var player: CharacterBody2D
var bee: Bee

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	await owner.ready
	bee = owner as Bee
	assert(bee != null, "BeeState requires a Bee node as its owner.")
