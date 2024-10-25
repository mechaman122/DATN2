extends Node2D

@export var animation_player: AnimationPlayer
@onready var label: Label = $Label
@onready var timer: Timer = $Timer

var body_entered: bool = false
var rng = RandomNumberGenerator.new().randf_range(0, 1)

func _ready() -> void:
	label.hide()
	label.text = "Press " + "F" + " to open"

func _on_interactable_area_body_entered(body: Node2D) -> void:
	if body is Player:
		label.show()
		body_entered = true

func interact():
	if rng <= 0.3:
		animation_player.play("open_gem")
	else :
		animation_player.play("open")
	label.hide()
	timer.start()


func _on_interactable_area_body_exited(body: Node2D) -> void:
	if body is Player:
		label.hide()
		body_entered = false


func _on_timer_timeout() -> void:
	queue_free()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_interact") && body_entered == true:
			interact()
