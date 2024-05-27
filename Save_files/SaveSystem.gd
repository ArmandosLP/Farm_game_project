extends Node


func save_game():
	var fileWirter := FileAccess.open("res://Save_files/player_inventory.json",FileAccess.WRITE)
	var inventory = InventoryManager.ply_inventory

	var data : String = "["
	for i in range(0,inventory.items.size(),1):
		if inventory.items[i] != null:
			data += "{\"itemID\": \"" + str(inventory.items[i].id) + "\",\"amount\": \"" + str(inventory.amount[i]) + "\"},"
		else:
			data += "null,"
	data += "]"

	fileWirter.store_string(data)
	fileWirter.close()


func load_game():
	var fileWirter := FileAccess.open("res://Save_files/player_inventory.json",FileAccess.READ)
	var items = JSON.parse_string(fileWirter.get_as_text())

	InventoryManager.initialize()
	var ply_inventory = InventoryManager.ply_inventory

	for i in range(0,items.size(),1):
		if items[i] != null:
			InventoryManager.set_item(
				ply_inventory,
				i,
				Items.get_item_by_id(int(items[i].itemID)),
				int(items[i].amount)
				)
	fileWirter.close()


