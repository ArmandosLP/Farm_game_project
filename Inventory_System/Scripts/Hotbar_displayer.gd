extends Control
class_name Hotbar_displayer

@onready var item_grid_container = %Item_grid_container
const hotbar_item_grid_cell_preload = preload("res://Inventory_System/Scenes/Hotbar_item_grid_cell.tscn")
var inventory : Inventory

var hotbar_grid_cells: Array[Hotbar_grid_cell] = []
var selected_hotbar_cell : int

#func _input(event):
	#if !InventorySystem.inventory_oppened:
		#hotbar_scroll(event)
		#hotking(event)
		#hotbar_use_action(event)

func hotbar_use_action(event : InputEvent):
	if event is InputEventMouse:
		if event.is_action_pressed("Mouse_left_click"):
			pass
			#InventorySystem.hotbar_left_click(inventory,selected_hotbar_cell)
		if event.is_action_pressed("Mouse_right_click"):
			#InventorySystem.hotbar_right_click(inventory,selected_hotbar_cell)
			pass
func hotbar_scroll(event : InputEvent):
	if event is InputEventMouse:
		hotbar_grid_cells[selected_hotbar_cell].selector.visible = false
		if event.is_action_pressed("Mouse_down_scroll"):
			if selected_hotbar_cell >= 6:
				selected_hotbar_cell = 0
			else:
				selected_hotbar_cell += 1
		elif event.is_action_pressed("Mouse_up_scroll"):
			if selected_hotbar_cell <= 0:
				selected_hotbar_cell = 6
			else:
				selected_hotbar_cell -= 1
		hotbar_grid_cells[selected_hotbar_cell].selector.visible = true
		#InventorySystem.hotbar_index = selected_hotbar_cell

func hotking(event : InputEvent):
	if event is InputEventKey:
		for i in range(0,7,1):
			if event.is_action_pressed("Hotbar_hotkey_" + str(i + 1)):
				hotbar_grid_cells[selected_hotbar_cell].selector.visible = false
				selected_hotbar_cell = i
				hotbar_grid_cells[selected_hotbar_cell].selector.visible = true
				#InventorySystem.hotbar_index = selected_hotbar_cell
				break

func _ready():
	#inventory = InventorySystem.player_inventory
	selected_hotbar_cell = 0
	remove_item_grid_cells()
	add_hotbar_grid_cells()
	update_all_cells()
	hotbar_grid_cells[selected_hotbar_cell].selector.visible = true

func remove_item_grid_cells():
	hotbar_grid_cells.clear()
	for item_grid_cell in item_grid_container.get_children():
		item_grid_container.remove_child(item_grid_cell)
		item_grid_cell.queue_free()

func add_hotbar_grid_cells():
	for id in range(0,7,1):
		var hotbar_grid_cell = hotbar_item_grid_cell_preload.instantiate()
		hotbar_grid_cell.inventory = inventory
		hotbar_grid_cell.id = id
		hotbar_grid_cells.append(hotbar_grid_cell)
		item_grid_container.add_child(hotbar_grid_cell)

func update_all_cells():
	for hotbar_grid_cell in item_grid_container.get_children():
		hotbar_grid_cell.update()
