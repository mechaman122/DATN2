extends Resource

class_name Inv

signal update
signal use_item

@export var slots: Array[InvSlot]

func insert(item: InvItem):
	var item_slots = slots.filter(func(slot): return slot.item == item)
	if !item_slots.is_empty():
		item_slots[0].amount += 1
		update.emit()
	else:
		var empty_slots = slots.filter(func(slot): return slot.item == null)
		if !empty_slots.is_empty():
			empty_slots[0].item = item
			empty_slots[0].amount = 1
			update.emit()
		else:
			print("Inventory is full")

func use_item_at_index(index: int):
	if index < 0 || index >= slots.size() || !slots[index].item:
		return

	var slot = slots[index]

	use_item.emit(slot.item)
	
	if slot.amount > 1:
		slot.amount -= 1
	else:
		slot.item = null
		slot.amount = 0
	update.emit()
