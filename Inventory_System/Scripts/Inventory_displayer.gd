extends CanvasLayer
class_name Inventory_Displayer

@onready var control = %Control
@onready var item_grid_container = %Item_grid_container
const item_grid_cell_preload = preload("res://Inventory_System/Scenes/Item_grid_cell.tscn")
var inventory : Inventory

func _ready():
	remove_item_grid_cells()
	add_item_grid_cells()
	update_item_grid_cells()
	
func change_scale(value : float):
	control.scale = Vector2(value,value)

func remove_item_grid_cells():
	for item_grid_cell in item_grid_container.get_children():
		item_grid_container.remove_child(item_grid_cell)
		item_grid_cell.queue_free() 

func add_item_grid_cells():
	for id in range(0,28,1):
		var item_grid_cell = item_grid_cell_preload.instantiate()
		item_grid_cell.inventory = inventory
		item_grid_cell.id = id
		item_grid_container.add_child(item_grid_cell)

func update_item_grid_cells():
	for item_grid_cell in item_grid_container.get_children():
		item_grid_cell.update()

