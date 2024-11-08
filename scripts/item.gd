extends Resource
class_name Item


@export var item_name: String

@export var texture: Texture2D
@export_multiline var description: String
@export_enum("Common", "Rare", "Epic", "Legendary")
var rarity: String = "Common"
