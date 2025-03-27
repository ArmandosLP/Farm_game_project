extends Node

const CORN = preload("res://Inventory_system_v2/Items/Corn.tres")
const CORN_SEEDS = preload("res://Inventory_system_v2/Items/Corn_seeds.tres")
const LIMON = preload("res://Inventory_system_v2/Items/Limon.tres")
const MANZANA_VERDE = preload("res://Inventory_system_v2/Items/Manzana verde.tres")
const MANZANA = preload("res://Inventory_system_v2/Items/Manzana.tres")
const NARANJA = preload("res://Inventory_system_v2/Items/Naranja.tres")
const PERA = preload("res://Inventory_system_v2/Items/Pera.tres")
const JADE_RING = preload("res://Inventory_system_v2/Items/Jade_ring.tres")
const PICKAXE_DEBUG = preload("res://Inventory_system_v2/Items/Pickaxe_debug.tres")
const MI_ITEM = preload("res://Inventory_system_v2/Items/mi item.tres")

var id : Dictionary = {
	1: CORN,
	2: CORN_SEEDS,
	3: LIMON,
	4: MANZANA_VERDE,
	5: MANZANA,
	6: NARANJA,
	7: PERA,
	10: JADE_RING,
	11: PICKAXE_DEBUG,
	99: MI_ITEM,
}

func get_item_by_id(_id : int):
	return id[_id]
