extends Node2D

@export var id: String

@export_category("Stats")
@export var weapon_name: String
@export var is_ranged: bool
@export_enum("Sword", "Hammer", "Bow", "Gun", "Staff")
var type: String = "Sword"
@export_enum("Common", "Rare", "Epic", "Legendary")
var rarity: String = "Common"
@export var damage: int
@export var crit: int
@export var level: int
@export var texture: Texture2D
@export_multiline var description: String


@export_category("Passive")
@export_enum("Buff", "DoT")
var passive_type: String
@export var passive_attribute: String
@export var attribute_stat: int
@export var passive_information: String
