extends Control
class_name Inventory_displayer_grid

@onready var continer_0 = %Continer0
@onready var continer_1 = %Continer1

@onready var tab_0_button = %Tab_0_button
@onready var tab_1_button = %Tab_1_button

var current_displayer_tab:int = 0
func _ready():
	hide_buttons()
	current_displayer_tab = 0

func get_current_tab_displayers():
	if current_displayer_tab == 0:
		return continer_0.get_children()
	else:
		return continer_1.get_children()

func get_all_displays():
	var displayer_array : Array[Inventory_Displayer] = []
	displayer_array.append_array(continer_0.get_children()) 
	displayer_array.append_array(continer_1.get_children())
	return displayer_array

func open(chests : Array[Chest_Structure]):
	remove_displayers()
	hide_buttons()
	for chest in chests:
		if chest.inventory_displayer.get_parent() == null:
			add_displayer(chest.inventory_displayer)

func remove_displayers():
	for displayer in get_all_displays():
		if displayer != InventorySystem.player_inventory_displayer:
			displayer.get_parent().remove_child(displayer)

func remove_displayer(displayer : Inventory_Displayer):
	if displayer.get_parent() != null:
		displayer.get_parent().remove_child(displayer)
		order_continers()
		if continer_1.get_child_count() <= 0:
			hide_buttons()
		check_all_displayers_if_mouse_inside()
		InventorySystem.hide_description()

func add_displayer(displayer : Inventory_Displayer):
	if displayer.get_parent() == null:
		if continer_0.get_child_count() < 4:
			continer_0.add_child(displayer)
		elif continer_1.get_child_count() < 4:
			continer_1.add_child(displayer)
			show_buttons()
		else:
			print("TO MANY INVENTORY DISPLAYERS")
		check_all_displayers_if_mouse_inside()
		InventorySystem.hide_description()

func check_all_displayers_if_mouse_inside():
	for displayer in get_all_displays():
		displayer.uncheck_all_cells()
	for displayer in get_current_tab_displayers():
		displayer.check_if_mouse_inside()

func _on_tab_1_button_down():
	continer_1.visible = false
	continer_0.visible = true
	current_displayer_tab = 0

func _on_tab_2_button_down():
	continer_1.visible = true
	continer_0.visible = false
	current_displayer_tab = 1

func order_continers():
	if continer_0.get_child_count() < 4 and continer_1.get_child_count() > 0:
		var displayer = continer_1.get_child(0)
		continer_1.remove_child(displayer)
		continer_0.add_child(displayer)
		
func show_buttons():
	tab_0_button.visible = true
	tab_1_button.visible = true
	
func hide_buttons():
	tab_0_button.visible = false
	tab_1_button.visible = false
	continer_1.visible = false
	continer_0.visible = true
	current_displayer_tab = 0
