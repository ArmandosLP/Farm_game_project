extends Control
class_name Hotbar_displayer

@onready var item_grid_container = %Item_grid_container
const hotbar_item_grid_cell_preload = preload("res://Inventory_System/Scenes/Hotbar_item_grid_cell.tscn")
var inventory : Inventory  = InventorySystem.player_inventory

func _ready():
	remove_item_grid_cells()
	add_item_grid_cells()
	
func remove_item_grid_cells():
	for item_grid_cell in item_grid_container.get_children():
		item_grid_container.remove_child(item_grid_cell)
		item_grid_cell.queue_free()

func add_item_grid_cells():
	for id in range(0,7,1):
		var item_grid_cell = hotbar_item_grid_cell_preload.instantiate()
		item_grid_cell.inventory = inventory
		item_grid_cell.id = id
		item_grid_container.add_child(item_grid_cell)

func update_all_cells():
	for item_grid_cell in item_grid_container.get_children():
		item_grid_container.update()
