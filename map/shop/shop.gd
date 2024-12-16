extends Node2D

@onready var label: Label = $Label
var touch_body: Node2D = null
var player : CharacterBody2D
var out_shop = false

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Adventurer")
	label.text = "Press F to open"

func _process(delta: float) -> void:
	$AnimationPlayer.play("idle")
	if touch_body != null && Input.is_action_just_pressed("ui_interact"):
		shop()
	if touch_body == null && out_shop == true:
		$ShopScene/AnimationPlayer.play("close")
		out_shop = false

func shop():
	out_shop = true
	$ShopScene/AnimationPlayer.play("open")

func _on_open_body_entered(body: Node2D) -> void:
	if body is Player:
		label.show()
		touch_body = body

func _on_open_body_exited(body: Node2D) -> void:
	if body is Player:
		label.hide()
		touch_body = null
