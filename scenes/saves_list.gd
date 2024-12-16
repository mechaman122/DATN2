extends VBoxContainer

# the player_continue_data being used is in scripts folder

var save_file_path = "user://save/"
var data_list: Array[PlayerContinueData] = []
var curr_data_index: int = -1
var curr_file_name: String = ""

func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)


func load_data(file_name):
	var data_to_load = ResourceLoader.load(save_file_path + file_name).duplicate(true)
	SavedData.load_data(data_to_load)
	print("loaded")


func save_data():
	var data_to_save = SavedData.save_data()
	ResourceSaver.save(data_to_save, save_file_path + data_to_save.created_date + ".tres")
	print("saved")


func _ready():
	verify_save_directory(save_file_path)
	dir_content(save_file_path)

func dir_content(path):
	for button in get_children():
		button.queue_free()
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			print("Found file: " + file_name)
			var data_resource: PlayerContinueData = SafeResourceLoader.load(path + file_name)
			data_list.append(data_resource)
			
			var button = Button.new()
			button.pressed.connect(_on_pressed.bind(button))
			button.text = str(file_name)
			add_child(button)
			
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path")
		

func _on_pressed(button: Button):
	var index = button.get_index()
	curr_data_index = index
	curr_file_name = button.text
	if data_list[index] != null:
		%Level.text = "Floor " + str(data_list[index].level)
		%Health.text = "Health: " + str(data_list[index].max_health) + " / " + str(data_list[index].health)
		%Armor.text = "Armor: " + str(data_list[index].max_armor)
		%BaseStats.text = "Base stats: " + str(data_list[index].base_stats)
		%WeaponsList.text = "Weapons: "
		for weapon in data_list[index].weapons:
			%WeaponsList.text += (str(weapon.stats.item_name) + ", ")
		%EquippedArmor.text = "Equipped Armor: " + (str(data_list[index].equipped_armor.stats.item_name) if data_list[index].equipped_armor != null else "None")
	else:
		OS.alert("Executable code detected! Check file authencity!")
	SoundManager.play_sfx("cursor2_sfx")
	


func _on_load_button_pressed() -> void:
	SavedData.load_data(data_list[curr_data_index])
	SavedData.save_data_name = str(curr_file_name)
	SavedData.can_quit_without_losing_save = false
	SceneTransitor.start_transition_to("res://scenes/game.tscn")
	SoundManager.fade_out("bgm_1", 2)


func _on_delete_button_pressed() -> void:
	%DeleteDialog.visible = true


func _on_delete_dialog_confirmed() -> void:
	DirAccess.remove_absolute("user://save/" + curr_file_name)
	dir_content(save_file_path)
