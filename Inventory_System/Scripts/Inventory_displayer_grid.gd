extends Control
class_name Inventory_displayer_grid

const inventory_displayer_preload = preload("res://Inventory_System/Scenes/Inventory_displayer.tscn")

@onready var grid_container = %GridContainer

func add_inventory_displayer(displayer : Inventory_Displayer):
	grid_container.add_child(displayer)

func remove_inventory_displayer(displayer : Inventory_Displayer):
	grid_container.remove_child(displayer)

func get_inventory_displayer_list():
	return grid_container.get_children()

#func update():
	#remove_all_displayers()
	#for inventory in InventorySystem.inventory_list:
		#var inventory_displayer = inventory_displayer_preload.instantiate()
		#inventory_displayer.inventory = inventory
		#grid_container.add_child(inventory_displayer)

func open(chests : Array[Chest_Structure]):
	remove_displayers()
	for chest in chests:
		if chest.inventory_displayer.get_parent() == null:
			grid_container.add_child(chest.inventory_displayer)

func remove_displayers():
	for displayer in grid_container.get_children():
		if displayer != InventorySystem.player_inventory_displayer:
			grid_container.remove_child(displayer)

func remove_displayer(displayer : Inventory_Displayer):
	if displayer.get_parent() != null:
		grid_container.remove_child(displayer)

func add_displayer(displayer : Inventory_Displayer):
	if displayer.get_parent() == null:
		grid_container.add_child(displayer)
