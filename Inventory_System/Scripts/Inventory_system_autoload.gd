extends CanvasLayer

const description_displayer_preload = preload("res://Inventory_System/Scenes/Description_displayer.tscn")
const mouse_item_displayer_preload = preload("res://Inventory_System/Scenes/Mouse_item_displayer.tscn")
const inventory_displayer_preload = preload("res://Inventory_System/Scenes/Inventory_displayer.tscn")
const hotbar_displayer_preload = preload("res://Inventory_System/Scenes/Hotbar_displayer.tscn")
const continer_displayer_preload = preload("res://Inventory_System/Scenes/Continer_displayer.tscn")

var player_inventory_displayer:Inventory_Displayer

var mouse_item_displayer:Mouse_item_displayer
var description_displayer:Item_description_displayer
var player_hotbar:Hotbar_displayer
var continer_displayer:Continer_Displayer

var cursor_item:Item
var cursor_amount:int

var hotbar_index : int

var player_inventory:Inventory

var inventory_oppened:bool = false 
var continer_oppened:bool = false 

func _ready():
	player_inventory = Inventory.new()
	
	player_inventory_displayer = inventory_displayer_preload.instantiate()
	player_inventory_displayer.inventory = player_inventory
	add_child(player_inventory_displayer)
	player_inventory_displayer.visible = false
	
	continer_displayer = continer_displayer_preload.instantiate()
	add_child(continer_displayer)
	
	description_displayer = description_displayer_preload.instantiate()
	add_child(description_displayer)
	description_displayer.z_index = 5
	description_displayer.visible = false
	
	player_hotbar = hotbar_displayer_preload.instantiate()
	add_child(player_hotbar)
	
	mouse_item_displayer = mouse_item_displayer_preload.instantiate()
	mouse_item_displayer.z_index = 5
	add_child(mouse_item_displayer)
	
	close_inventory()

func left_click(inventory : Inventory, id : int) -> void:
	if !quick_acces_key:
		if put_together_cursor_to_cell(inventory,id):
			pass
		elif put_from_cursor_to_cell(inventory,id):
			pass
		elif put_from_cell_to_cursor(inventory,id):
			pass
		elif exchange_cell_and_cursor(inventory,id):
			pass
	elif continer_oppened and quick_acces_key:
		if put_from_inventory_cell_to_continer(inventory,id):
			pass
		elif put_from_continer_cell_to_inventory(inventory,id):
			pass
	player_inventory_displayer.update_all_item_grid_cells()
	mouse_item_displayer.update()

func right_click(_inventory : Inventory, _id : int) -> void:
	pass

func put_from_continer_cell_to_inventory(inventory : Inventory,cell_id : int):
	if inventory != player_inventory:
		if inventory.items[cell_id] != null:
			for i in range(0,player_inventory.items.size(),1):
				var extra = add_item(
					player_inventory_displayer,
					inventory.items[cell_id],
					inventory.amount[cell_id])
				inventory.amount[cell_id] -= inventory.amount[cell_id] - extra
				if inventory.amount[cell_id] == 0:
					inventory.items[cell_id] = null
					description_displayer.hide_description()
					return true
	return false

func put_from_inventory_cell_to_continer(inventory,cell_id):
	if inventory == player_inventory:
		var continer = continer_displayer.oppened_inventory_displayer.inventory
		if inventory.items[cell_id] != null:
			for i in range(0,continer.items.size(),1):
				var extra = add_item(
					continer_displayer.oppened_inventory_displayer,
					inventory.items[cell_id],
					inventory.amount[cell_id])
				inventory.amount[cell_id] -= inventory.amount[cell_id] - extra
				if inventory.amount[cell_id] == 0:
					inventory.items[cell_id] = null
					description_displayer.hide_description()
					return true
	return false

func put_together_cursor_to_cell(inventory : Inventory, cell_id : int) -> bool:
	if cursor_item != null and cursor_item == inventory.items[cell_id] and cursor_item.max_stack > inventory.amount[cell_id]:
		print("put_together_cursor_to_cell")
		if cursor_item.max_stack >= inventory.amount[cell_id] + cursor_amount:
			inventory.amount[cell_id] += cursor_amount
			cursor_amount = 0
			cursor_item = null
		else:
			cursor_amount = (cursor_amount + inventory.amount[cell_id]) - cursor_item.max_stack
			inventory.amount[cell_id] = cursor_item.max_stack
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

func open_inventory():
	if !continer_oppened and player_inventory_interaction:
		inventory_oppened = true
		player_inventory_displayer.get_parent().remove_child(player_inventory_displayer)
		add_child(player_inventory_displayer)
		player_inventory_displayer.anchors_preset = player_inventory_displayer.PRESET_CENTER
		player_inventory_displayer.visible = true
		description_displayer.visible = true
		player_hotbar.visible = false
		player_inventory_displayer.check_if_mouse_inside()

func close_inventory():
	if player_inventory_interaction and inventory_oppened:
		player_inventory_displayer.visible = false
		description_displayer.visible = false
		player_hotbar.visible = true
		player_hotbar.update_all_cells()
		InventorySystem.hide_description()
		uncheck_last_focused_cell()
		inventory_oppened = false

func open_continer(displayer : Inventory_Displayer):
	if !inventory_oppened:
		continer_oppened = true
		player_hotbar.visible = false
		continer_displayer.open_continer(displayer)

func close_continer():
	if continer_oppened:
		InventorySystem.allow_player_inventory_interaction(true)
		player_hotbar.update_all_cells()
		player_hotbar.visible = true
		continer_displayer.close_continer()
		StaticSystemScript.player.can_move(true)
		continer_oppened = false
		allow_continer_interaction(true)

func hotbar_left_click(inventory : Inventory,id : int):
	pass

func hotbar_right_click(inventory : Inventory,id : int):
	pass

var player_inventory_interaction : bool = true
func allow_player_inventory_interaction(state : bool):
	player_inventory_interaction = state

var continer_interaction : bool = true
func allow_continer_interaction(state : bool):
	continer_interaction = state

var last_focused_cell : Item_grid_cell_displayer
func uncheck_last_focused_cell():
	if last_focused_cell != null:
		last_focused_cell.unchek()
		last_focused_cell = null

func _input(event):
	if event is InputEventKey and event.is_action_pressed("Inventory_action_key"):
		if continer_oppened:
			close_continer()
		else:
			if !inventory_oppened:
				open_inventory()
			else:
				close_inventory()

var quick_acces_key:bool = false
func _physics_process(delta):
	if Input.is_action_pressed("Inventory_quick_access"):
		quick_acces_key = true
	else:
		quick_acces_key = false

func set_item_player_inventory(grid_cell : int, item : Item, amount : int):
	if player_inventory.items[grid_cell] == null:
		player_inventory.items[grid_cell] = item
		player_inventory.amount[grid_cell] = amount
		player_inventory_displayer.update_item_grid_cell(grid_cell)
		return true
	return false

func add_item(inventory_displayer : Inventory_Displayer ,item : Item, amount : int) -> int:
	var amount_to_add:int = amount
	var inventory = inventory_displayer.inventory
	for i in range(0,inventory.items.size(),1):
		if inventory.items[i] == item:
			if inventory.amount[i] + amount_to_add <= item.max_stack:
				inventory.amount[i] += amount_to_add
				inventory_displayer.update_item_grid_cell(i)
				amount_to_add = 0
				
				player_hotbar.update_all_cells()
				
				return amount_to_add
			else:
				amount_to_add = inventory.amount[i] + amount_to_add - item.max_stack
				inventory.amount[i] = item.max_stack
				inventory_displayer.update_item_grid_cell(i)
	for i in range(0,inventory.items.size(),1):
		if inventory.items[i] == null:
			inventory.items[i] = item
			if amount_to_add <= item.max_stack:
				inventory.amount[i] = amount_to_add
				inventory_displayer.update_item_grid_cell(i)
				amount_to_add = 0
				
				player_hotbar.update_all_cells()
				
				return amount_to_add
			else:
				inventory.amount[i] = item.max_stack
				amount_to_add -= item.max_stack
				inventory_displayer.update_item_grid_cell(i)
	player_hotbar.update_all_cells()
	return amount_to_add

func reduce_item(inventory_displayer : Inventory_Displayer ,id : int, amount : int) -> bool:
	if inventory_displayer.inventory.amount[id] >= amount:
		inventory_displayer.inventory.amount[id] -= amount
		if inventory_displayer.inventory.amount[id] == 0:
			inventory_displayer.inventory.items[id] = null
		inventory_displayer.update_item_grid_cell(id)
		player_hotbar.update_all_cells()
		return true
	else:
		inventory_displayer.update_item_grid_cell(id)
		player_hotbar.update_all_cells()
		return false
