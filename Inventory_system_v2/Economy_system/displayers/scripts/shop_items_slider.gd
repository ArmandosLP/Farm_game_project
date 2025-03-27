extends PanelContainer

@onready var slider_space = %SliderSpace
@onready var slider = %Slider

@export var max = 4
var value = 0

var slider_size:float
var spots = {}
var spot_size:float
signal slider_moved(value)


func slide_up():
	if is_visible_in_tree():
		if value > 0:
			value -= 1
			slider.position.y = spots[value]
			slider_moved.emit(value)


func slide_down():
	if is_visible_in_tree():
		if value < max:
			value += 1
			slider.position.y = spots[value]
			slider_moved.emit(value)


func _on_slider_space_draw():
	spots.clear()
	slider_size = slider_space.size.y
	slider_size -= slider.size.y
	spot_size = slider_size / max
	
	spots[0] = 0
	
	for i in range(1,max ,1):
		spots[i] = slider_size / max * i
	
	spots[max] = slider_size
	value = 0
	slider.position.y = spots[0]
	

var slider_focus:bool = false
func mouse_left_click():
	slider_focus = true

var change : float = 0
func _input(event):
	if event.is_action_released("Mouse_left_click"):
		if slider_focus:
			slider_focus = false
	if slider_focus:
		var mouse_pos = get_local_mouse_position().y
		for i in range(0,spots.size(),1):
			if mouse_pos > spots[i] - spot_size / 2 and mouse_pos < spots[i] - spot_size / 2 + spot_size + slider.size.y / 2:
				if value != i:
					value = i
					slider.position.y = spots[i]
					slider_moved.emit(value)
				break
	if event.is_action_pressed("Mouse_up_scroll"):
		slide_up()
	if event.is_action_pressed("Mouse_down_scroll"):
		slide_down()


func _on_mouse_entered():
	pass


func _on_mouse_exited():
	pass
