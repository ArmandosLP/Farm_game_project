extends Resource
class_name Inventory

var items : Array[Item]
var amount : Array[int]

func _init():
	items.resize(28)
	amount.resize(28)

func has_free_space() -> bool:
	for item in items:
		if item == null: return true
	return false

func has_item(item:Item) -> int:
	for id in range(0,items.size(),1):
		if items[id] == item: return id
	return -1

func can_stack(item:Item) -> bool:
	for id in range(0,items.size(),1):
		if items[id] == item and amount[id] < items[id].max_stack: return true
	return false
