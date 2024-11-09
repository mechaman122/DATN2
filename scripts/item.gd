extends Resource
class_name Item


@export var item_name: String

@export var texture: Texture2D
@export var animated_texture: Texture2D #this is for weapon that requires animation such as bow
@export_multiline var description: String
@export_enum("Common", "Rare", "Epic", "Legendary")
var rarity: String = "Common"

@export var stats = {}

@export var passives = {}
