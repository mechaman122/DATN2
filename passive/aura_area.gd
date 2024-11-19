extends Area2D
class_name AuraArea

var damage: int = 2


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage, null)



func set_aura(amount = 2):
	damage = amount
	$AnimationPlayer.play("DamageOverTime")
