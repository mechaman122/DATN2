extends Weapon

class_name Bow

const ARROW_SCENE: PackedScene = preload("res://weapons/projectile/arrow.tscn")


func shoot_arrow(size: float) -> void:
	var arrow: Projectile = ARROW_SCENE.instantiate()
	arrow.scale = Vector2(size,size)
	get_tree().current_scene.add_child(arrow)
	var arrow_position = $ArrowPosition.global_position
	if randf() < crit_rate:
		arrow.launch(arrow_position, global_position.direction_to(arrow_position), 800, roundi(self.damage * 1.5))
	else:
		arrow.launch(arrow_position, global_position.direction_to(arrow_position), 800, self.damage)
