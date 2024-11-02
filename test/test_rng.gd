extends Node2D

const ROOM_TYPE = ["starting", "shop", "treasure", "enemy", "temple", "well", "trade", "ending"]
const SPAWN_RATE = [0, 0.1, 0.1, 0.5, 0.1, 0.1, 0.1, 0]
var spawn_time = [0, 0, 0, 0, 0, 0, 0, 0]

func _ready():
	for i in range(1000):
		weightedRandomChoice(ROOM_TYPE, SPAWN_RATE)
	print(spawn_time)

func weightedRandomChoice(choices, weights):
	var table = []
	for i in range(choices.size()):
		for j in range(weights[i] * 100):
			table.append(i)
	var value = table[randi() % table.size()]
	var choice = choices[value]
	spawn_time[value] += 1
	return choice
