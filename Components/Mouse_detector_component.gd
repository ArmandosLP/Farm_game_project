extends Area2D
class_name MouseDetectorComponent

var mouse_inside:bool = false

func _on_mouse_entered():
	mouse_inside = true
	if owner.has_method("mouse_entered"):
		owner.mouse_entered()


func _on_mouse_exited():
	mouse_inside = false
	if owner.has_method("mouse_exited"):
		owner.mouse_exited()


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouse and mouse_inside:
		if owner.has_method("mouse_left_click") and event.is_action_pressed("Mouse_left_click"):
			owner.mouse_left_click()
		elif owner.has_method("mouse_right_click") and event.is_action_pressed("Mouse_right_click"):
			owner.mouse_right_click()
			
		if owner.has_method("mouse_left_click_released") and event.is_action_released("Mouse_left_click"):
			owner.mouse_left_click_released()
		if owner.has_method("mouse_right_click_released") and event.is_action_released("Mouse_right_click"):
			owner.mouse_right_click_released()


func _on_tree_entered():
	owner.set_meta(&"MouseDetectorComponent",self)


func _on_tree_exited():
	owner.remove_meta(&"MouseDetectorComponent")
