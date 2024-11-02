extends PanelContainer

@onready var border: ReferenceRect = get_node("ReferenceRect")
@onready var texture_rect: TextureRect = get_node("TextureRect")

@export var weapon_stats: WeaponStats = null:
	set(value):
		weapon_stats = value
		if value != null:
			texture_rect.texture = value.texture
			match value.rarity:
				"Rare": border.set_border_color(Color("#ffffff40"))
				"Epic": border.set_border_color(Color("PURPLE"))
				"Legendary": border.set_border_color(Color("YELLOW"))

func initialize(stats: WeaponStats) -> void:
	self.weapon_stats = stats
	
func select() -> void:
	border.show()
	
func deselect() -> void:
	border.hide()


func _on_mouse_entered() -> void:
	if weapon_stats == null:
		return
	Popups.item_popup(Rect2i(Vector2i(global_position), Vector2i(size)), weapon_stats)


func _on_mouse_exited() -> void:
	Popups.item_hidepopup()
