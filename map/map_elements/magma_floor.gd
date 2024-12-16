extends StaticBody2D
 
var knockback : Vector2 

func _ready() -> void:
	$AnimationPlayer.play("burn")
