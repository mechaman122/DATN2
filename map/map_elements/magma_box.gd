extends Destructible

var MAGMA_FLOOR_SCENE: PackedScene = preload("res://map/map_elements/magma_floor.tscn")

func _process(delta: float) -> void:
	if breaked:
		breaked = false
		await animation_player.animation_finished
		var magma_floor = MAGMA_FLOOR_SCENE.instantiate()
		magma_floor.position = position
		get_tree().current_scene.add_child(magma_floor)
		get_tree().current_scene.move_child(magma_floor, 1)
