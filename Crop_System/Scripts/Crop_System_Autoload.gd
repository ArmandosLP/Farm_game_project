extends Node

var crop_structure_dictionary : Array[Crop_Structure]
 
func update_all_crops():
	for crop in crop_structure_dictionary:
		crop.update()

func add_crop(crop : Crop_Structure):
	crop_structure_dictionary.append(crop)

func remove_crop(crop : Crop_Structure):
	var index = crop_structure_dictionary.find(crop)
	if index != -1:
		crop_structure_dictionary.remove_at(index)
