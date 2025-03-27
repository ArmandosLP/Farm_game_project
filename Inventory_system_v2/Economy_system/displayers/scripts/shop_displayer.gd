extends PanelContainer
class_name Shop_Displayer


const SHOP_GRID_CELL = preload("res://Inventory_system_v2/Economy_system/displayers/scenes/shop_grid_cell.tscn")


var shop:Shop
@onready var shop_grid_continer = %Shop_grid_continer
@onready var shop_items_slider = %ShopItemsSlider


func build(_shop:Shop):
	remove_shop_grid_cells()
	shop = _shop
	shop_items_slider.visible = false
	index = 4
	for i in range(0,shop.selling_items.size(),1):
		var shop_grid_cell = SHOP_GRID_CELL.instantiate()
		shop_grid_cell.id = i
		shop_grid_continer.add_child(shop_grid_cell)
		shop_grid_cell.update(shop)
		if i >= 4:
			shop_grid_cell.visible = false
			shop_items_slider.visible = true
	shop_items_slider.max = shop_grid_continer.get_child_count() - 4


func remove_shop_grid_cells():
	for shop_grid_cell in shop_grid_continer.get_children():
		shop_grid_continer.remove_child(shop_grid_cell)
		shop_grid_cell.queue_free()


var index:int
func _on_shop_items_slider_slider_moved(_value):
	var value = _value + 4
	if int(value) != index:
		index = value
		for id in range(0,shop_grid_continer.get_child_count(),1): 
			if id >= index - 4 and id < index:
				shop_grid_continer.get_child(id).visible = true
			else:
				shop_grid_continer.get_child(id).visible = false
