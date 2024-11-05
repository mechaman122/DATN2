extends PanelContainer

@onready var border: ReferenceRect = get_node("ReferenceRect")
@onready var texture_rect: TextureRect = get_node("TextureRect")

@export var item_stats: Item = null:
	set(value):
		item_stats = value
		if value != null:
			texture_rect.texture = value.texture
			match value.rarity:
				"Rare": border.set_border_color(Color("#ffffff40"))
				"Epic": border.set_border_color(Color("PURPLE"))
				"Legendary": border.set_border_color(Color("YELLOW"))
				
func _ready() -> void:
	texture_rect.texture = null

func initialize(stats: Item) -> void:
	self.item_stats = stats
	
func select() -> void:
	border.show()
	
func deselect() -> void:
	border.hide()


func _on_mouse_entered() -> void:
	if item_stats == null:
		return
	Popups.item_popup(Rect2i(Vector2i(global_position), Vector2i(size)), item_stats)


func _on_mouse_exited() -> void:
	Popups.item_hidepopup()
