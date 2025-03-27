extends CanvasLayer

const MONEY_DISPLAYER = preload("res://Inventory_system_v2/Economy_system/displayers/scenes/money_displayer.tscn")

var player_money:int = 100

var money_displayer:MoneyDisplayer


func initialize():
	money_displayer = MONEY_DISPLAYER.instantiate()
	add_child(money_displayer)
	money_displayer.set_money(player_money)


func set_money(amount:int):
	player_money = amount
	money_displayer.set_money(amount)


func take_money(amount:int) -> bool:
	if amount <= player_money:
		player_money -= amount
		money_displayer.set_money(player_money)
		return true
	return false


func right_click(shop:Shop,id:int):
	var selling:Salling_item = shop.selling_items[id]
	if take_money(selling.item.price * selling.price_modifier * 5):
		InventoryManager.add_item(InventoryManager.ply_inventory,selling.item,5)


func left_click(shop:Shop,id:int):
	var selling:Salling_item = shop.selling_items[id]
	if take_money(selling.item.price * selling.price_modifier):
		InventoryManager.add_item(InventoryManager.ply_inventory,selling.item,1)
