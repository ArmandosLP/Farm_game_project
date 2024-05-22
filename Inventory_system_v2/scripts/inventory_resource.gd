extends Resource
class_name Inventory

var items : Array[Item]
var amount : Array[int]

func _init():
	items.resize(28)
	amount.resize(28)
