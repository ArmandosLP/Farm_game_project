extends Control

const mouse_item_cell_preload = preload("res://Inventory_System/Scenes/Mouse_item_cell.tscn")
const inventory_displayer_preload = preload("res://Inventory_System/Scenes/Inventory_displayer.tscn")
var inventory_displayer : Inventory_Displayer
var mouse_item_cell : Mouse_item_cell

var cursor_item : Item
var player_inventory : Inventory

func _ready():
	player_inventory = Inventory.new()
	
	inventory_displayer = inventory_displayer_preload.instantiate()
	inventory_displayer.inventory = player_inventory
	add_child(inventory_displayer)
	
	mouse_item_cell = mouse_item_cell_preload.instantiate()
	inventory_displayer.control.add_child(mouse_item_cell)

func click(inventory : Inventory, id : int) -> void:
	if put_from_cursor_to_cell(inventory,id):
		pass
	elif put_from_cell_to_cursor(inventory,id):
		pass
	elif exchange_cell_and_cursor(inventory,id):
		pass
	mouse_item_cell.update()

func put_from_cursor_to_cell(inventory : Inventory, cell_id : int):
	if cursor_item != null and inventory.items[cell_id] == null:
		inventory.items[cell_id] = cursor_item
		cursor_item = null
		return true
	else:
		return false

func put_from_cell_to_cursor(inventory : Inventory, cell_id : int):
	if cursor_item == null and inventory.items[cell_id] != null:
		cursor_item = inventory.items[cell_id]
		inventory.items[cell_id] = null
		return true
	else:
		return false

func exchange_cell_and_cursor(inventory : Inventory, cell_id : int):
	if cursor_item != null and inventory.items[cell_id] != null:
		var extra = cursor_item
		cursor_item = inventory.items[cell_id]
		inventory.items[cell_id] = extra
		return true
	else:
		return false

