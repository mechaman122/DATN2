class_name Player extends CharacterBody2D

const speed = 100.0

@onready var animated_sprite = $AnimatedSprite2D
@onready var animated_player = $AnimationPlayer

@onready var health = $Health

@onready var health_bar = $Interface/LifeBar/TextureProgressBar
@onready var melee_hitbox = $MeleeHitbox/CollisionShape2D

@export var inv: Inv

var health_changed = false
var knockback_direction = Vector2()

func _on_health_health_depleted() -> void:
	pass

func _ready() -> void:
	health_bar.value = 100
	inv.use_item.connect(use_item)


func _on_health_health_changed(diff: int) -> void:
	# change the percentage of the health bar
	health_bar.value = (float(health.health) / float(health.max_health)) * 100
	if diff < 0:
		health_changed = true

func _on_health_max_health_changed(diff: int) -> void:
	# change the percentage of the health bar
	health_bar.value = (float(health.health) / float(health.max_health)) * 100
	
func player():
	pass

func collect(item):
	inv.insert(item)

func use_item(item: InvItem) -> void:
	item.use(self)
