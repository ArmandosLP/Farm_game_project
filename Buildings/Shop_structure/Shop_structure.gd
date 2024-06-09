extends Node2D
@onready var player_interaction_detector_component = %PlayerInteractionDetectorComponent

const SHOP_TEST = preload("res://Inventory_system_v2/Economy_system/shops/shop_test.tres")
func mouse_left_click():
	if player_interaction_detector_component.player_inside:
		InventoryManager.open_shop(SHOP_TEST)

func player_exited_area():
	InventoryManager.close_shop()
