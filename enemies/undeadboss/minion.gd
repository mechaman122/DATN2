extends Enemy

@onready var animation_sprite = $AnimatedSprite2D
var player : CharacterBody2D
func _ready() -> void:
	health.max_health = 1
	health.health = 1
	animation_sprite.play("idle")
	await animation_sprite.animation_finished

func _physics_process(_delta):
	player = get_tree().get_first_node_in_group("Adventurer")
	var dir = player.position - position
	velocity = dir.normalized() * 60
	move_and_slide()
	if health.health <= 0 :
		queue_free()
