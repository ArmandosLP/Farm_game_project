extends CanvasLayer

const DISPLAYER_GRID = preload("res://Inventory_system_v2/displayers/displayer_grid.tscn")
const INVENTORY_DISPLAYER = preload("res://Inventory_system_v2/displayers/Inventory_displayer.tscn")
const MOUSE_ITEM_DISPLAYER = preload("res://Inventory_system_v2/displayers/Cursor_item_displayer.tscn")

var displayer_grid : GridContainer #Contenedor de todos los inventarios

var cursor_item_displayer : Cursor_item_displayer

var ply_inventory : Inventory #Inventarios del jugador, siempre accesible
var ply_inventory_displayer : Inventory_Displayer

var cursor_item : Item #Objeto del cursor, siempre accesible
var cursor_amount : int

func _ready():
	displayer_grid = DISPLAYER_GRID.instantiate()
	add_child(displayer_grid)
	displayer_grid.visible = false
	
	cursor_item_displayer = MOUSE_ITEM_DISPLAYER.instantiate()
	add_child(cursor_item_displayer)
	cursor_item = preload("res://Inventory_System/Resources/Fruts_and_vegis/Manzana.tres")
	cursor_amount = 12
	cursor_item_displayer.update()
	
	ply_inventory_displayer = INVENTORY_DISPLAYER.instantiate()
	displayer_grid.add_child(ply_inventory_displayer)
	
	ply_inventory = Inventory.new()
	"""--------DEBUG_CODE--------"""
	ply_inventory.items[2] = preload("res://Inventory_System/Resources/Fruts_and_vegis/Manzana.tres")
	ply_inventory.amount[2] = 6
	
	ply_inventory.items[12] = preload("res://Inventory_System/Resources/Fruts_and_vegis/Naranja.tres")
	ply_inventory.amount[12] = 3
	"""--------------------------"""
	ply_inventory_displayer.build(ply_inventory)

func left_click(inventory:Inventory,id:int) -> void:
	if cursor_item != null and inventory.items[id] == null:
		put_item(inventory,id)
	elif cursor_item == null and inventory.items[id] != null:
		take_item(inventory,id)
	elif cursor_item == inventory.items[id] and cursor_item != null:
		joid_items(inventory,id)
	elif cursor_item != null and inventory.items[id] != null:
		exchange_items(inventory,id)
	cursor_item_displayer.update()

func right_click(inventory:Inventory,id:int) -> void:
	pass

func set_visibility(change:bool) -> void:
	displayer_grid.visible = change

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
