extends Node

class_name DungeonRoom

var coord: Vector2i = Vector2i(0, 0)
var size: Vector2i = Vector2i(0, 0)
var room_type: int = 0
var room_elements: Dictionary = {}

const TREASURE = 1
const TRAP_FLOOR = 2
const BOX = 3
const BOX_WITH_ITEM = 4
const BOX_WITH_EXPLOSION = 5
const SHOP = 6
const ENEMY = 7
const BOSS = 8
