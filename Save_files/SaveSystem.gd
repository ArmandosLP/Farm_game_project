extends Node



func save_game():

	var fileWirter := FileAccess.open("res://Save_files/player_inventory.json",FileAccess.WRITE)
	var inventory = Inventory.new()
	inventory.items[0] = Items.MANZANA
	
	var data := {
		"inventory": inventory
	}
	
	fileWirter.store_string(JSON.stringify(data))
	fileWirter.close()


func load_game():
	pass


