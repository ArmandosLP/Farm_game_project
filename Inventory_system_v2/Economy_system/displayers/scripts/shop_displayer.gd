extends PanelContainer
class_name Shop_Displayer


const SHOP_GRID_CELL = preload("res://Inventory_system_v2/Economy_system/displayers/scenes/shop_grid_cell.tscn")


var shop:Shop
@onready var shop_grid_continer = %Shop_grid_continer


func build(shop:Shop):
	remove_shop_grid_cells()
	for selling_item in shop.selling_items:
		shop_grid_continer.add_child(SHOP_GRID_CELL.instantiate())


func remove_shop_grid_cells():
	for shop_grid_cell in shop_grid_continer.get_children():
		shop_grid_continer.remove_child(shop_grid_cell)
		shop_grid_cell.queue_free()
