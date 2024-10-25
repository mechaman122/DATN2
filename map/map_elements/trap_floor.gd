extends Node2D

func _ready() -> void:
	var anim: Animation = $AnimationPlayer.get_animation("rise")
	anim.loop_mode = (Animation.LOOP_LINEAR)
