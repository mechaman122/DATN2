class_name Player extends CharacterBody2D

enum {UP, DOWN}

const speed = 100.0

var current_weapon

@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer

@onready var health = $Health

@onready var melee_hitbox = $MeleeHitbox/CollisionShape2D
@onready var weapons = get_node("Weapon")

@export var inv: Inv

var has_weapon = false
var health_changed = false
var knockback_direction = Vector2()

func _ready() -> void:
	inv.use_item.connect(use_item)
	if weapons.get_child_count() > 0:
		current_weapon = weapons.get_child(0)
		has_weapon = true

func _process(delta: float) -> void:
	var mouse_dir: Vector2 = (get_global_mouse_position() - global_position).normalized()
	
	if velocity.x < 0:
		animated_sprite.flip_h = true
	elif velocity.x > 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = mouse_dir.x < 0 

	if has_weapon:
		if not current_weapon.is_busy():
			if Input.is_action_just_released("ui_prev_weapon"):
				_switch_weapon(UP)
			elif Input.is_action_just_released("ui_next_weapon"):
				_switch_weapon(DOWN)
		current_weapon.move(mouse_dir)
		current_weapon.get_input()
	
func player():
	pass

func collect(item):
	inv.insert(item)

func use_item(item: InvItem) -> void:
	item.use(self)

func _switch_weapon(direction: int) -> void:
	if !has_weapon:
		return
	var index: int = current_weapon.get_index()
	if direction == UP:
		index -= 1
		if index < 0:
			index = weapons.get_child_count() - 1
	else:
		index += 1
		if index > weapons.get_child_count() - 1:
			index = 0
	current_weapon.hide()
	current_weapon = weapons.get_child(index)
	current_weapon.show()
