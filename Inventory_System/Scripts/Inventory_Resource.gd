extends Resource
class_name Inventory

var items : Array[Item]

func _init():
	items.resize(28)
	items[0] = Items.DEBUG_APPLE_ITEM
	items[6] = Items.DEBUG_APPLE_ITEM
	

	

