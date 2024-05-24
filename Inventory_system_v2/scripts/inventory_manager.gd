extends CanvasLayer

const CURSOR_ITEM_DISPLAYER = preload("res://Inventory_system_v2/displayers/Scenes/cursor_item_displayer.tscn")
const DESCRIPTION_DISPLAYER = preload("res://Inventory_system_v2/displayers/Scenes/description_displayer.tscn")
const DISPLAYER_GRID = preload("res://Inventory_system_v2/displayers/Scenes/displayer_grid.tscn")
const HOTBAR_DISPLAYER = preload("res://Inventory_system_v2/displayers/Scenes/hotbar_displayer.tscn")
const INVENTORY_DISPLAYER = preload("res://Inventory_system_v2/displayers/Scenes/inventory_displayer.tscn")

var displayer_grid : GridContainer #Contenedor de todos los inventarios

var cursor_item_displayer : Cursor_item_displayer

var ply_inventory : Inventory #Inventarios del jugador, siempre accesible
var ply_inventory_displayer : Inventory_Displayer

var cont_inventory : Inventory
var cont_inventory_displayer : Inventory_Displayer

var hotbar_displayer : Hotbar_displayer

var description_displayer : Description_displayer

var cursor_item : Item #Objeto del cursor, siempre accesible
var cursor_amount : int

var allow_inventory_interaction : bool = true

func _ready():
	displayer_grid = DISPLAYER_GRID.instantiate()
	add_child(displayer_grid)
	displayer_grid.visible = false
	
	cursor_item_displayer = CURSOR_ITEM_DISPLAYER.instantiate()
	add_child(cursor_item_displayer)
	cursor_item_displayer.update()
	
	hotbar_displayer = HOTBAR_DISPLAYER.instantiate()
	add_child(hotbar_displayer)
	
	ply_inventory_displayer = INVENTORY_DISPLAYER.instantiate()
	displayer_grid.add_child(ply_inventory_displayer)
	
	ply_inventory = Inventory.new()
	
	ply_inventory_displayer.build(ply_inventory)
	hotbar_displayer.build(ply_inventory)
	
	description_displayer = DESCRIPTION_DISPLAYER.instantiate()
	add_child(description_displayer)
	description_displayer.visible = false
	
	cont_inventory_displayer = INVENTORY_DISPLAYER.instantiate()
	cont_inventory_displayer.visible = false
	displayer_grid.add_child(cont_inventory_displayer)


func left_click(inventory:Inventory,id:int) -> void:
	if cursor_item != null and inventory.items[id] == null:
		put_item(inventory,id)
		description_displayer.show_desc(inventory.items[id])
	elif cursor_item == null and inventory.items[id] != null:
		take_item(inventory,id)
		description_displayer.hide_desc()
	elif cursor_item == inventory.items[id] and cursor_item != null:
		joid_items(inventory,id)
		description_displayer.show_desc(inventory.items[id])
	elif cursor_item != null and inventory.items[id] != null:
		exchange_items(inventory,id)
	cursor_item_displayer.update()


func right_click(inventory:Inventory,id:int) -> void:
	pass


func set_visibility(change:bool) -> void:
	if allow_inventory_interaction:
		if !cont_inventory_displayer.visible:
			displayer_grid.visible = change
			hotbar_displayer.visible = !change
		else:
			close_continer()


func get_visibility() -> bool:
	return displayer_grid.visible


func joid_items(inventory:Inventory,id:int) -> void:
	if inventory.amount[id] + cursor_amount < cursor_item.max_stack:
		inventory.amount[id] += cursor_amount
		cursor_amount = 0
		cursor_item = null
	else:
		cursor_amount = (cursor_amount + inventory.amount[id]) - cursor_item.max_stack
		inventory.amount[id] = cursor_item.max_stack


func put_item(inventory:Inventory,id:int) -> void:
	inventory.items[id] = cursor_item
	cursor_item = null
	inventory.amount[id] = cursor_amount
	cursor_amount = 0


func take_item(inventory:Inventory,id:int) -> void:
	cursor_item = inventory.items[id]
	inventory.items[id] = null
	cursor_amount = inventory.amount[id]
	inventory.amount[id] = 0


func exchange_items(inventory:Inventory,id:int) -> void:
	var extra_item = cursor_item
	var extra_amount = cursor_amount
	cursor_item = inventory.items[id]
	inventory.items[id] = extra_item
	cursor_amount = inventory.amount[id]
	inventory.amount[id] = extra_amount


func open_continer(inventory:Inventory):
	cont_inventory = inventory
	cont_inventory_displayer.build(cont_inventory)
	hotbar_displayer.visible = false
	cont_inventory_displayer.visible = true
	displayer_grid.visible = true


func close_continer():
	cont_inventory = null
	cont_inventory_displayer.visible = false
	displayer_grid.visible = false
	hotbar_displayer.visible = true
	StaticSystemScript.player.can_move(true)


func add_item(inventory:Inventory,item:Item,amount:int) -> int:
	var _amount = amount
	for i in range(0,inventory.items.size(),1):
		if inventory.items[i] == item and inventory.amount[i] < item.max_stack:
			if item.max_stack > inventory.amount[i] + _amount: 
				inventory.amount[i] += _amount
				_amount = 0
				update_displayer(inventory,i)
				break
			else:
				_amount = inventory.amount[i] + _amount - item.max_stack
				inventory.amount[i] = item.max_stack
				update_displayer(inventory,i)
		elif inventory.items[i] == null:
			inventory.items[i] = item
			if _amount <= item.max_stack:
				inventory.amount[i] = _amount
				_amount = 0
				update_displayer(inventory,i)
				break
			else:
				inventory.amount[i] = item.max_stack
				_amount -= item.max_stack
				update_displayer(inventory,i)
	return _amount


func update_displayer(inventory:Inventory,id:int):
	if inventory == ply_inventory:
		ply_inventory_displayer.update_item_grid_cell(ply_inventory,id)
		if !get_visibility():
			hotbar_displayer.update_cell(inventory,id)
	elif inventory == cont_inventory:
		cont_inventory_displayer.update_item_grid_cell(cont_inventory,id)
