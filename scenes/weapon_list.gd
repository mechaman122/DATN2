extends VBoxContainer

const root_path = "res://weapons/resources/"

var weapons: Array[WeaponStats] = []

func _ready():
	dir_content(root_path)

func dir_content(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			print("Found file: " + file_name)
			if file_name == "weapon_stats.gd":
				break
			var weapon_resource: WeaponStats = load(path + file_name)
			weapons.append(weapon_resource)
			
			var button = Button.new()
			button.pressed.connect(_on_pressed.bind(button))
			button.text = weapon_resource.item_name
			add_child(button)
			
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path")
	print(weapons)

func _on_pressed(button: Button):
	var index = button.get_index()
	%Texture.texture = weapons[index].texture
	%Name.text = "Name:  " + weapons[index].item_name
	%Type.text = "Type:  " + weapons[index].type
	%Rarity.text = "Rarity:  " + weapons[index].rarity
	%Damage.text = "Damage:  " + str(weapons[index].weapon_damage)
	%Crit.text = "Crit:  " + str(weapons[index].weapon_crit)
	%Description.text = weapons[index].description
	SoundManager.play_sfx("res://assets/sounds/Cursor_tones/cursor_style_2.wav")
	
