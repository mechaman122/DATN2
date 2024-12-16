extends Button

@onready var option_list: Array = [
	"+ 1 Damage", 
	"+ 1 Max Health",
	"+ 0.5% Atk Speed",
	"+ 1% Speed",
	"+ 0.5% Crit",
	"Earn some coins"
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.connect("pressed", _on_button_pressed)


func _on_button_pressed():
	if text == "+ 1 Damage":
		SavedData.base_stats["damage"] += 1
	elif text == "+ 1 Max Health":
		SavedData.max_health += 1
		SavedData.health += 1
	elif text == "+ 0.5% Atk Speed":
		SavedData.base_stats["atk_speed"] += 0.05
	elif text == "+ 1% Speed":
		SavedData.base_stats["speed"] += 1
	elif text == "+ 0.5% Crit":
		SavedData.base_stats["crit"] += 0.05
	elif text == "Earn some coins":
		SavedData.coins += (SavedData.level * randi_range(1,3))
		
	get_parent().hide()
	get_tree().paused = false
