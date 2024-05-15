extends CanvasLayer

const description_displayer_preload = preload("res://Inventory_System/Scenes/Description_displayer.tscn")
const mouse_item_displayer_preload = preload("res://Inventory_System/Scenes/Mouse_item_displayer.tscn")
const inventory_displayer_preload = preload("res://Inventory_System/Scenes/Inventory_displayer.tscn")
const hotbar_displayer_preload = preload("res://Inventory_System/Scenes/Hotbar_displayer.tscn")
const inventory_continer_preload = preload("res://Inventory_System/Scenes/Inventory_continer.tscn")

var inventory_continer : Inventory_continer

var inventory_displayer : Inventory_Displayer
var mouse_item_displayer : Mouse_item_displayer
var description_displayer : Item_description_displayer
var player_hotbar : Hotbar_displayer

var cursor_item : Item
var cursor_amount : int

var player_inventory : Inventory

func _ready():
	inventory_continer = inventory_continer_preload.instantiate()
	add_child(inventory_continer)
	
	player_inventory = Inventory.new()
	
	player_inventory.items[8] = Items.DEBUG_APPLE
	player_inventory.amount[8] = 3
	
	player_inventory.items[5] = Items.DEBUG_APPLE_2
	player_inventory.amount[5] = 3
	
	player_inventory.items[2] = Items.DEBUG_APPLE_3
	player_inventory.amount[2] = 3
	
	player_inventory.items[3] = Items.DEBUG_APPLE_4
	player_inventory.amount[3] = 3
	
	player_inventory.items[9] = Items.DEBUG_APPLE_5
	player_inventory.amount[9] = 3
	
	inventory_displayer = inventory_displayer_preload.instantiate()
	inventory_displayer.inventory = player_inventory
	inventory_continer.add_inventory_displayer(inventory_displayer)
	
	player_hotbar = hotbar_displayer_preload.instantiate()
	add_child(player_hotbar)
	
	mouse_item_displayer = mouse_item_displayer_preload.instantiate()
	inventory_continer.add_child(mouse_item_displayer)
	
	description_displayer = description_displayer_preload.instantiate()
	description_displayer.visible = false
	add_child(description_displayer)
	
	close_player_inventory()

func left_click(inventory : Inventory, id : int) -> void:
	if put_together_cursor_to_cell(inventory,id):
		pass
	elif put_from_cursor_to_cell(inventory,id):
		pass
	elif put_from_cell_to_cursor(inventory,id):
		pass
	elif exchange_cell_and_cursor(inventory,id):
		pass
	mouse_item_displayer.update()
	inventory_displayer.update_item_grid_cells()

func right_click(inventory : Inventory, id : int) -> void:
	pass

func put_together_cursor_to_cell(inventory : Inventory, cell_id : int) -> bool:
	if cursor_item != null and cursor_item == inventory.items[cell_id] and cursor_item.max_stack > inventory.amount[cell_id]:
		if cursor_item.max_stack >= inventory.amount[cell_id] + cursor_amount:
			inventory.amount[cell_id] += cursor_amount
			cursor_amount = 0
			cursor_item = null
		else:
			cursor_amount = (cursor_amount + player_inventory.amount[cell_id]) - cursor_item.max_stack
			player_inventory.amount[cell_id] = cursor_item.max_stack
		show_description(inventory, cell_id)
		return true
	else:
		return false

func put_from_cursor_to_cell(inventory : Inventory, cell_id : int) -> bool:
	if cursor_item != null and inventory.items[cell_id] == null:
		inventory.items[cell_id] = cursor_item
		cursor_item = null
		inventory.amount[cell_id] = cursor_amount
		cursor_amount = 0
		show_description(inventory, cell_id)
		return true
	else:
		return false

func put_from_cell_to_cursor(inventory : Inventory, cell_id : int) -> bool:
	if cursor_item == null and inventory.items[cell_id] != null:
		cursor_item = inventory.items[cell_id]
		inventory.items[cell_id] = null
		cursor_amount = inventory.amount[cell_id]
		inventory.amount[cell_id] = 0
		hide_description()
		return true
	else:
		return false

func exchange_cell_and_cursor(inventory : Inventory, cell_id : int) -> bool:
	if cursor_item != null and inventory.items[cell_id] != null:
		var extra_item = cursor_item
		var extra_amount = cursor_amount
		cursor_item = inventory.items[cell_id]
		inventory.items[cell_id] = extra_item
		cursor_amount = inventory.amount[cell_id]
		inventory.amount[cell_id] = extra_amount
		return true
	else:
		return false

func show_description(inventory : Inventory, id : int):
	if cursor_item == null:
		description_displayer.show_description(inventory.items[id])

func hide_description():
	description_displayer.hide_description()

var inventory_oppened:bool = true 

func open_player_inventory():
	description_displayer.visible = true
	inventory_displayer.visible = true
	inventory_oppened = true
	player_hotbar.visible = false

func close_player_inventory():
	inventory_displayer.visible = false
	description_displayer.visible = false
	inventory_oppened = false
	player_hotbar.visible = true
	player_hotbar.update_all_cells()
	InventorySystem.hide_description()
	
	
var inventory_list : Array[Inventory] = []
	
func add_inventory(inventory : Inventory):
	inventory_list.append(inventory)
	var inventory_continer_displayer = inventory_displayer_preload.instantiate()
	inventory_continer_displayer.inventory = inventory
	inventory_continer.add_inventory_displayer(inventory_continer_displayer)
	
func remove_displayer(inventory_displayer : Inventory_Displayer):
	print("test")
	inventory_continer.remove_inventory_displayer(inventory_displayer)
	inventory_displayer.queue_free()
	
func remove_inventory(inventory : Inventory):
	var inventory_list_position = inventory_list.find(inventory_displayer.inventory)
	if inventory_list_position != -1:
		inventory_list.remove_at(inventory_list_position)
	
	
	
	
	
	
	
	
func hotbar_left_click(inventory : Inventory,id : int):
	if inventory.items[id] != null:
		print("Left click")

func hotbar_right_click(inventory : Inventory,id : int):
	if inventory.items[id] != null:
		print("Right click")
