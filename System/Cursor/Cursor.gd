extends Node

const cursor_layout_preload = preload("res://System/Cursor/cursor_layout.tscn")

var cursor_layout : Control

func _ready():
	var cursor_layout = cursor_layout_preload.instantiate()
	add_child(cursor_layout)
	

