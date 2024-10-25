class_name Gladiator extends CharacterBody2D
 
var knockback_direction = Vector2()

@onready var animated_sprite = $AnimatedSprite2D
@onready var gladiator_hitbox = $Hitbox/CollisionShape2D
@onready var animation_player = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Health.health <= 0:
		queue_free()

func _physics_process(delta):
	move_and_slide()

	if  velocity.x > 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true
