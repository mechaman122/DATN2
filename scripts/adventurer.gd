class_name Player extends CharacterBody2D

const speed = 100.0

@onready var animated_sprite = $AnimatedSprite2D
@onready var health = $Health
@onready var health_bar = $Interface/LifeBar/TextureProgressBar

func _on_health_health_depleted() -> void:
	pass

func _ready() -> void:
	health_bar.value = 100


func _on_health_health_changed(diff: int) -> void:
	# change the percentage of the health bar
	health_bar.value = (float(health.health) / float(health.max_health)) * 100

func _on_health_max_health_changed(diff: int) -> void:
	# change the percentage of the health bar
	health_bar.value = (float(health.health) / float(health.max_health)) * 100
