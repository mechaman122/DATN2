class_name Projectile
extends Node2D

@export var sprite: Sprite2D

var direction = Vector2.ZERO
var speed: float = 500

@onready var timer = $Timer
@onready var hitbox = $Hitbox
@onready var impact_detector = $ImpactDetector

func _ready() -> void:
	set_as_top_level(true)
	look_at(position + direction)
	
	timer.timeout.connect(queue_free)
	timer.start(3)
	
	impact_detector.body_entered.connect(_on_impact)


func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_impact(_body: Node2D) -> void:
	queue_free()


func _on_timer_time_out() -> void:
	queue_free()
