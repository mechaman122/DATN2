extends CanvasLayer

var new_scene: String
@onready var option_list = $HBoxContainer

@onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")


func start_transition_to(path_to_scene: String) -> void:
	new_scene = path_to_scene
	anim_player.play("change_scene")

func change_scene() -> void:
	var __ = get_tree().change_scene_to_file(new_scene) == OK
	assert(__)

func show_options() -> void:
	if SavedData.level % 2 == 0:
		get_tree().paused = true
		for button in option_list.get_children():
			button.text = button.option_list.pick_random()
		option_list.show()
