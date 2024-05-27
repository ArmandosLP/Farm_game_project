extends PanelContainer

@onready var check_box_fullscreen = %CheckBox_fullscreen

var config:Dictionary 

func _ready():
	config = SaveSystem.read_config_file()
	check_box_fullscreen.set_pressed(config.fullscreen)


func _on_check_box_fullscreen_toggled(toggled_on):
	config.fullscreen = toggled_on

func _on_apply_pressed():
	SaveSystem.save_config_file(config)
	if config.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_leave_pressed():
	queue_free()
