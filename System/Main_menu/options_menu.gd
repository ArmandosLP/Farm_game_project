extends PanelContainer

@onready var check_box_fullscreen = %CheckBox_fullscreen

var fullscreen = DisplayServer.WINDOW_MODE_WINDOWED

func _on_check_box_fullscreen_toggled(toggled_on):
	if toggled_on:
		fullscreen = DisplayServer.WINDOW_MODE_FULLSCREEN
	else:
		fullscreen = DisplayServer.WINDOW_MODE_WINDOWED

func _on_apply_pressed():
	DisplayServer.window_set_mode(fullscreen)

func _on_leave_pressed():
	queue_free()
