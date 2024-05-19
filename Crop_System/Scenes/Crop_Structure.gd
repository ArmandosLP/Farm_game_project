extends Node2D

@onready var plant_sprite = %Plant_sprite
@onready var mouse_detector = %MouseDetectorComponent

var planted : Plant
var phase : int
var age : int

func plant(_planted : Plant):
	planted = _planted
	phase = 0
	age = 0
	plant_sprite.texture = planted.texture
	plant_sprite.hframes = planted.grow_time_for_phase.size() + 1
	plant_sprite.frame = phase
	
func update():
	if planted != null and phase < planted.grow_time_for_phase.size():
		age += 1
		if age >= planted.grow_time_for_phase[phase]:
			age = 0
			phase += 1
			plant_sprite.frame = phase

func mouse_left_click():
	update()
	
func mouse_right_click():
	if InventorySystem.player_inventory.items[InventorySystem.player_hotbar.selected_hotbar_cell] == Items.MANZANA:
		plant(CORN_PLANT)
		
func cultivate():
	if phase == planted.grow_time_for_phase.size():
		InventorySystem.add_item(InventorySystem.player_inventory_displayer,planted.reward_item,1)
		planted = null
		phase = 0
		age = 0
		plant_sprite.texture = null
	
func _input(event):
	if event.is_action_pressed("Debug_key") and  mouse_detector.mouse_inside:
		cultivate()
		
const CORN_PLANT = preload("res://Crop_System/Scenes/corn_plant.tres")
