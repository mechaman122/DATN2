class_name Player extends CharacterBody2D

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
		current_weapon.move(mouse_dir)
		current_weapon.get_input()
	
func player():
	pass

func collect(item):
	inv.insert(item)

func use_item(item: InvItem) -> void:
	item.use(self)
