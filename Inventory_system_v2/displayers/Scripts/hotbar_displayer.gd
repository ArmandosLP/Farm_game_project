extends Control
class_name Hotbar_displayer

const HOTBAR_GRID_CELL = preload("res://Inventory_system_v2/displayers/Scenes/hotbar_grid_cell.tscn")

@onready var hotbar_grid = %Hotbar_grid

var inventory : Inventory
var selected_cell : int

func _ready():
	selected_cell = 3
	remove_hotbar_grid_cells()
	add_hotbar_grid_cells()
	hotbar_grid.get_child(selected_cell).select()


func build(_inventory:Inventory):
	inventory = _inventory
	for i in range(0,7,1):
		hotbar_grid.get_child(i).update(inventory)


func update_cell(_inventory:Inventory,_id:int):
	hotbar_grid.get_child(_id).update(_inventory)


func _input(event):
	if !InventoryManager.get_visibility():
		hotbar_scroll(event)
		hotking(event)
		hotbar_action(event)


func hotbar_action(event : InputEvent):
	if event is InputEventMouse:
		if event.is_action_pressed("Mouse_left_click"):
			InventoryManager.hotbar_action(inventory.items[selected_cell])
		if event.is_action_pressed("Mouse_right_click"):
			pass


func hotbar_scroll(event : InputEvent):
	if event is InputEventMouse:
		hotbar_grid.get_child(selected_cell).unselect()
		
		if event.is_action_pressed("Mouse_down_scroll"):
			selected_cell += 1
		elif event.is_action_pressed("Mouse_up_scroll"):
			selected_cell -= 1
		
		if selected_cell > 6:
			selected_cell = 0
		elif selected_cell < 0:
			selected_cell = 6
			
		hotbar_grid.get_child(selected_cell).select()


func hotking(event : InputEvent):
	if event is InputEventKey:
		for i in range(0,7,1):
			if event.is_action_pressed("Hotbar_hotkey_" + str(i + 1)):
				hotbar_grid.get_child(selected_cell).unselect()
				selected_cell = i
				hotbar_grid.get_child(selected_cell).select()
				break


func remove_hotbar_grid_cells():
	for cell in hotbar_grid.get_children():
		hotbar_grid.remove_child(cell)
		cell.queue_free()


func add_hotbar_grid_cells():
	for id in range(0,7,1):
		var hotbar_item_cell = HOTBAR_GRID_CELL.instantiate()
		hotbar_item_cell.id = id
		hotbar_grid.add_child(hotbar_item_cell)
