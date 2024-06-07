extends PanelContainer
class_name Inventory_Displayer

@onready var item_grid_container = %Item_grid_container

const ITEM_GRID_CELL = preload("res://Inventory_system_v2/displayers/Scenes/item_grid_cell.tscn")

var inventory : Inventory

func _ready():
	remove_item_grid_cells()
	add_item_grid_cells()


func build(_inventory : Inventory):
	inventory = _inventory
	for i in range(0,28,1):
		if inventory.items.size() > i:
			item_grid_container.get_child(i).visible = true
			item_grid_container.get_child(i).update(inventory)
		else:
			item_grid_container.get_child(i).visible = false


func update_item_grid_cell(_inventory:Inventory,_id:int):
	item_grid_container.get_child(_id).check_mouse_inside()
	item_grid_container.get_child(_id).update(_inventory)


func check_if_mouse_inside():
	for item_grid_cell in item_grid_container.get_children():
		item_grid_cell.check()


func remove_item_grid_cells():
	for item_grid_cell in item_grid_container.get_children():
		item_grid_container.remove_child(item_grid_cell)
		item_grid_cell.queue_free()


func add_item_grid_cells():
	for id in range(0,28,1):
		var item_grid_cell = ITEM_GRID_CELL.instantiate()
		item_grid_cell.id = id
		item_grid_container.add_child(item_grid_cell)
