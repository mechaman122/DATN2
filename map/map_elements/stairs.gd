extends Area2D

@onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		collision_shape.set_deferred("disabled", true)
		SceneTransitor.start_transition_to("res://map/map_test.tscn")
		SavedData.level += 1
		if SavedData.level % 5 == 0:
			SceneTransitor.start_transition_to("res://map/rooms/boss_room.tscn")
