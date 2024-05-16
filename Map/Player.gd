extends CharacterBody2D
class_name Player

@onready var animation_player = %AnimationPlayer
@onready var interaction_area = %Interaction_area

@export var walking_speed = 100
@export var running_speed = 130
var speed = walking_speed

var moving_direction = {
	right = 0,
	left = 0,
	up = 0,
	down = 0}

var moving_vector := Vector2(0,0)
var run := 0

func _ready():
	InventorySystem.player = self

func _process(_delta):
	#print(Engine.get_frames_per_second())
	moving_direction = {
		right = int(Input.is_action_pressed("Movment_right_key")),
		left = int(Input.is_action_pressed("Movment_left_key")),
		up = int(Input.is_action_pressed("Movment_up_key")),
		down = int(Input.is_action_pressed("Movment_down_key"))}
	run = int(Input.is_action_pressed("Movment_run_key"))
	animate_sprite()
	
func _physics_process(_delta):
	if movement_blocker:
		move_and_slide()
	moving_vector = Vector2i(moving_direction.right - moving_direction.left,moving_direction.down - moving_direction.up)
	if run == 1:
		speed = running_speed
	else:
		speed = walking_speed
	velocity = moving_vector.normalized() * speed
	
var state = "Idle"
var direction = "down"
func animate_sprite():
	if moving_vector == Vector2(0,0):
		state = "Idle"
	elif run == 0:
		state = "Walk"
	elif run == 1:
		state = "Run"
	
	match moving_vector:
		Vector2(-1,1),Vector2(0,1),Vector2(1,1):
			direction = "down"
		Vector2(-1,-1),Vector2(0,-1),Vector2(1,-1):
			direction = "up"
		Vector2(1,0):
			direction = "right"
		Vector2(-1,0):
			direction = "left"
	if movement_blocker:
		animation_player.play(state + "_" + direction)

var movement_blocker := true
func can_move(can : bool):
	movement_blocker = can
	animation_player.play("Idle" + "_" + direction)

func _input(_event):
	if Input.is_action_just_pressed("Full_screen_key"):
		if DisplayServer.window_get_mode() != 0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

	if Input.is_action_just_pressed("Inventory_action_key"):
		if !InventorySystem.inventory_oppened:
			InventorySystem.open_inventory()
		else:
			InventorySystem.close_inventory()

func get_chests():
	var chest_list : Array[Chest_Structure]
	for entity in interaction_area.get_overlapping_bodies():
		if entity != self and entity.has_method("get_inventory"):
			chest_list.append(entity)
	return chest_list

func _on_interaction_area_body_exited(body):
	if InventorySystem.inventory_oppened:
		if body != self and body.has_method("get_inventory"):
			InventorySystem.inventory_displayer_grid.remove_displayer(body.inventory_displayer)

func _on_interaction_area_body_entered(body):
	if InventorySystem.inventory_oppened:
		if body != self and body.has_method("get_inventory"):
			InventorySystem.inventory_displayer_grid.add_displayer(body.inventory_displayer)
