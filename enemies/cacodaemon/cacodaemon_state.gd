class_name CacodaemonState extends State

const IDLE = "Idle"
const CHASE = "Chase"
const HURT = "Hurt"
const DIE = "Die"

var cacodaemon: Cacodaemon

func _ready() -> void:
	await owner.ready
	cacodaemon = owner as Cacodaemon
	assert(cacodaemon != null, "CacodaemonState requires a Cacodaemon node as its owner.")
