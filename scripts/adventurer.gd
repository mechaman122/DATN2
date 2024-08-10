class_name Player extends CharacterBody2D

const speed = 100.0
@export var player_hp = 10
@export var player_max_hp = 12

@onready var animated_sprite = $AnimatedSprite2D


func _on_hurtbox_area_entered(area):
	player_hp = 0

# func _process(delta):
# 	# move camera to be in the center point between the player and the mouse
# 	var camera = get_node("Adventurer/Camera2D")
# 	var mouse_position = get_global_mouse_position()
# 	var player_position = global_position
# 	var center = (mouse_position + player_position) / 2
# 	camera.global_position = center
