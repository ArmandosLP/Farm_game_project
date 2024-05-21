extends Node2D
class_name Crop_Structure

@onready var plant_sprite = %Plant_sprite
@onready var mouse_detector = %MouseDetectorComponent
@onready var player_interaction_detector_component = %PlayerInteractionDetectorComponent

var planted : Plant
var phase : int
var age : int

func _ready():
	CropSystemAutoload.add_crop(self)

func plant(_planted : Plant):
	plant_sprite.z_index = 2 
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
			plant_sprite.z_index = 3
			age = 0
			phase += 1
			plant_sprite.frame = phase

func mouse_left_click():
	if player_interaction_detector_component.player_inside:
		var hand_item : Item = InventorySystem.player_inventory.items[InventorySystem.hotbar_index]
		if planted == null and hand_item != null and hand_item.can_be_planted:
			plant(hand_item.plant_resource)
			InventorySystem.reduce_item(InventorySystem.player_inventory_displayer,InventorySystem.hotbar_index,1)

func cultivate():
	if planted != null and phase == planted.grow_time_for_phase.size():
		InventorySystem.add_item(InventorySystem.player_inventory_displayer,planted.reward_item,1)
		planted = null
		phase = 0
		age = 0
		plant_sprite.texture = null
