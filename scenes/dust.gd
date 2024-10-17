extends Sprite2D

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("appear_dust")
