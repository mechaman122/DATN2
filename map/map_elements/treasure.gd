extends Node2D

@export var animation_player: AnimationPlayer
@onready var label: Label = $Label

var touch_body: Node2D = null

func _ready() -> void:
	label.text = "Press F to open"
	

func _process(delta: float) -> void:
	if touch_body != null && Input.is_action_just_pressed("ui_interact"):
		interact()


func interact():
	if randf() <= 0.4:
		animation_player.play("open_gem")
	else :
		animation_player.play("open")
	label.hide()


func _on_pickable_area_body_entered(body: Node2D) -> void:
	if body is Player:
		label.show()
		touch_body = body


func _on_pickable_area_body_exited(body: Node2D) -> void:
	if body is Player:
		label.hide()
		touch_body = null
