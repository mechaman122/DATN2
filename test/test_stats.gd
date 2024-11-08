extends Node2D

var temp

class Statss:
	var base: Dictionary = {}
	var modifier: Dictionary = {}
	func create(stats: Dictionary) -> void:
		base = stats.duplicate()
		
	func get_base(id):
		return self.base[id]	
		
		
	func add_modifier(id, mod):
		self.modifier[id] = {
			add = mod.add if "add" in mod else {},
			mult = mod.mult if "mult" in mod else {}
		} 


	func remove_modiifer(id):
		self.modifier[id] = null
		
		
	func get_total(id):
		var total = self.base[id] if id in self.base else 0
		var multiplier: float = 0
		
		for k in self.modifier:
			var v = self.modifier[k]
			total = total + (v.add[id] if id in v.add else 0)
			multiplier = multiplier + (v.mult[id] if id in v.mult else 0)
		return total + (total * multiplier)
		
		
func _ready() -> void:
	temp = Statss.new()
	
	temp.create(
		{
			max_hp = 100,
			hp = 100,
			stre = 10,
			spd = 10,
			intl = 10
		}
	)
	
	var magic_hat = {
		id = 1,
		modifier = {
			add = {
				stre = 5
			}
		}
	}
	
	temp.add_modifier(magic_hat.id, magic_hat.modifier)
	print_stats("stre")


func print_stats(id):
	var base = temp.get_base(id)
	var full = temp.get_total(id)
	var str = "%s->%d:%d" % [id, base, full]
	print(str)
