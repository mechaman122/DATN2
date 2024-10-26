extends Node2D

class_name Weapon; "res://assets/sprites/weapons/icons/sword_01.png"

@export var is_on_floor: bool = false
@export var is_ranged: bool = false

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
@onready var charge_particles: GPUParticles2D = get_node("Sprite2D/ChargeParticles")
@onready var hitbox: Hitbox = get_node("Sprite2D/Hitbox")
@onready var pickable_area: Area2D = get_node("PickableArea")
var tween: Tween = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not is_on_floor:
		pickable_area.set_collision_mask_value(1, false)
		pickable_area.set_collision_mask_value(2, false)

func get_input() -> void:
	if Input.is_action_just_pressed("ui_attack") and not animation_player.is_playing():
		animation_player.play("charge")
	elif Input.is_action_just_released("ui_attack"):
		if animation_player.is_playing() and animation_player.current_animation == "charge":
			animation_player.play("attack")
		elif charge_particles.emitting:
			animation_player.play("charged_attack")

func move(mouse_dir: Vector2) -> void:
	if is_ranged:
		var parent = get_parent()
		parent.rotation_degrees = rad_to_deg(mouse_dir.angle())
		if mouse_dir.x < 0:
			parent.scale.y = -1
		else:
			parent.scale.y = 1
	else:
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
	#animation_player.play("cancel_attack")
	animation_player.call_deferred("play", "cancel_attack")


func _on_pickable_area_body_entered(body: Node2D) -> void:
	if body != null:
		pickable_area.set_collision_mask_value(1, false)
		pickable_area.set_collision_mask_value(2, false)
		body.pick_up_weapon(self)
		position = Vector2.ZERO
	else:
		tween.kill()
		pickable_area.set_collision_mask_value(2, true)

func interpolate_pos(init_pos: Vector2, final_pos: Vector2) -> void:
	position = init_pos
	tween = create_tween()
	tween.tween_property(self, "position", final_pos, 0.8).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.connect("finished", _on_tween_completed)
	pickable_area.set_collision_mask_value(1, false)

func _on_tween_completed() -> void:
	pickable_area.set_collision_mask_value(2, true)

func get_texture() -> Texture:
	return get_node("Sprite2D").texture
