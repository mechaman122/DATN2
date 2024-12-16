extends Camera2D

@export var RANDOM_SHAKE_STRENGTH: float = 15.0
@export var SHAKE_DECAY_RATE: float = 5.0

@onready var rng = RandomNumberGenerator.new()

var shake_strength: float = 0.0

func _ready() -> void:
	rng.randomize()

func apply_shake() -> void:
	shake_strength = RANDOM_SHAKE_STRENGTH

func _process(delta: float) -> void:
	shake_strength = lerp(shake_strength, 0.0, SHAKE_DECAY_RATE * delta)

	self.offset = get_random_offset()


func get_random_offset() -> Vector2:
	var x = rng.randf_range(-shake_strength, shake_strength)
	var y = rng.randf_range(-shake_strength, shake_strength)

	return Vector2(x, y)
