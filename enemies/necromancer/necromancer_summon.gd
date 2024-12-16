extends NecromancerState

@export var speed := 40.0
var player: CharacterBody2D
var knockback_direction = Vector2()
var fliph = false
const EXPLODE_SCENE : PackedScene = preload("res://enemies/necromancer/fly.tscn")
@export var projectile_speed: int = 150
var explode = false

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	necromancer.animation_player.play("summon")
	explode = true
	#imp.timer.start()
	#imp.fire_player.play("fire")

func physics_update(delta: float) -> void:
	var dir = player.global_position - necromancer.global_position
	if explode:
		var projectile: Node2D = EXPLODE_SCENE.instantiate()
		projectile.launch(necromancer.global_position, dir.normalized(), 100, 1)
		get_tree().current_scene.add_child(projectile)
		explode = false
		#finished.emit(IDLE)
	#if not explode:
		#finished.emit(IDLE) 

func _on_hitbox_body_entered(hurtbox: Hurtbox) -> void:
	print(hurtbox)

#func _on_timer_timeout() -> void:
	#fire = true
	#finished.emit(ATK)
