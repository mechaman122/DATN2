extends Node2D

class_name Weapon; "res://assets/sprites/weapons/icons/sword_01.png"

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
@onready var charge_particles: GPUParticles2D = get_node("Sprite2D/ChargeParticles")
@onready var hitbox: Hitbox = get_node("Sprite2D/Hitbox")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func get_input() -> void:
	if Input.is_action_just_pressed("ui_attack") and not animation_player.is_playing():
		animation_player.play("charge")
	elif Input.is_action_just_released("ui_attack"):
		if animation_player.is_playing() and animation_player.current_animation == "charge":
			animation_player.play("attack")
		elif charge_particles.emitting:
			animation_player.play("charged_attack")

func move(mouse_dir: Vector2) -> void:
	if not animation_player.is_playing() or animation_player.current_animation == "charge":
		var parent = get_parent()
		parent.rotation = mouse_dir.angle()
		if parent.scale.y == 1 and mouse_dir.x < 0:
			parent.scale.y = -1
		elif parent.scale.y == -1 and mouse_dir.x > 0:
			parent.scale.y = 1

func is_busy():
	if animation_player.is_playing() or charge_particles.emitting:
		return true
	return false

func cancel_attack():
	animation_player.play("cancel_attack")
