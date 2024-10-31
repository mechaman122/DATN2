extends Node2D

@export var animation_player: AnimationPlayer
@onready var label: Label = $Label


func _ready() -> void:
	label.text = "Press F to open"
	

func interact():
	if randf() <= 0.4:
		animation_player.play("open_gem")
	else :
		animation_player.play("open")
	label.hide()


func detach():
	Popups.item_hidepopup()
	label.hide()
	

func pre_interact():
	Popups.item_popup(null, null)
	label.show()
