extends CharacterBody2D
class_name Enemy

var knockback = Vector2()
var health_changed = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var gladiator_hitbox = $Hitbox/CollisionShape2D
@onready var animation_player = $AnimationPlayer
@onready var health = get_node("Health")
@onready var attack_cooldown_timer = get_node("AttackCooldownTimer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health.health_changed.connect(_on_health_changed)
	health.health_depleted.connect(_on_health_depleted)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta):
	if health_changed:
		velocity = knockback * 10
		knockback = knockback.lerp(Vector2.ZERO, 0.1)
		health_changed = false
	move_and_slide()

	if  velocity.x > 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true

	# knockback when get hit
		
	
func _on_health_changed(difference):
	if difference < 0:
		health_changed = true
		print(health.health)

func _on_health_depleted():
	queue_free()
