extends Weapon

class_name Gun

const BULLET_SCENE: PackedScene = preload("res://weapons/projectile/gun_bullet.tscn")

@onready var firing_timer = $FiringTimer
@export var fire_rate: float = 100

func _ready() -> void:
	firing_timer.set_wait_time(1/fire_rate)
func get_input() -> void:
	if Input.is_action_just_pressed("ui_attack") and firing_timer.is_stopped():
		animation_player.play("attack")
		firing_timer.start()
	elif Input.is_action_pressed("ui_attack") and firing_timer.is_stopped():
		animation_player.play("attack")
		firing_timer.start()


func shoot() -> void:
	var bullet: Projectile = BULLET_SCENE.instantiate()
	get_tree().current_scene.add_child(bullet)
	var muzzle_position = $MuzzlePosition.global_position
	bullet.launch(muzzle_position, global_position.direction_to(muzzle_position), 1000)
