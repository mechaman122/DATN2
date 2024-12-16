extends CharacterBody2D
class_name Enemy

var knockback = Vector2()
var health_changed = false
var armor
var status_effects: Array[StatusEffect]
var init_pos = Vector2()
var active_center = Vector2()
var active_size = Vector2()
var def = 0
var armorbuff = false
var boss = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var hitbox = $Hitbox/CollisionShape2D
@onready var animation_player = $AnimationPlayer
@onready var health = get_node("Health")
@onready var attack_cooldown_timer = get_node("AttackCooldownTimer")
@onready var navigation2d = $NavigationAgent2D


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
		#health_changed = false
	move_and_slide()

	if  velocity.x > 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true

	# knockback when get hit
		
	
func _on_health_changed(difference):
	if difference < 0:
		health_changed = true

func _on_health_depleted():
	queue_free()

func apply_status_effect(effect: StatusEffect):
	for i in range(status_effects.size()):
		if status_effects[i].get_effect_name() == effect.get_effect_name():
			status_effects[i].duration = effect.duration
			return
			
	status_effects.append(effect)
	var effect_icon = TextureRect.new()
	effect_icon.texture = effect.icon_texture
	effect_icon.name = effect.get_effect_name()
	#effect_container.add_child(effect_icon)
	effect.apply(self)
	
	print(status_effects)


func take_damage(_damage: int, source, is_crit: bool = false) -> void:
	if health.health <= health.max_health/2 && def == 0 && boss == true:
		armorbuff = true
		def = 5
	if armor!= null && armor.armor > 0:
		armor.armor -= _damage
	elif _damage <= def:
		health.health -= 1
	else:
		health.health -= _damage - def
		health_changed = true
		#$AnimationPlayer.play("hurt")
		print(source)
	if health.health <= 0:
		EventBus.emit_signal("enemy_died", source)
		#health.health += 10
		#DamageNumbers.display_number(-10, global_position + Vector2(0,-16), false)
	DamageNumbers.display_number(_damage, global_position + Vector2(0,-16), is_crit)

func set_init_pos(intitpos: Vector2, active : Vector2, activesize : Vector2) -> void:
	init_pos = intitpos
	active_center = active
	active_size = activesize
