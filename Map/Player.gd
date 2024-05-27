extends CharacterBody2D
class_name Player

@onready var timer = %Timer
@onready var animation_player = %AnimationPlayer
@onready var audio_stream_player = $AudioStreamPlayer
@export var walking_speed = 100
@export var running_speed = 130
var speed = walking_speed

var moving_direction = {
	right = 0,
	left = 0,
	up = 0,
	down = 0,
	run = 0}


var moving_vector := Vector2(0,0)


func _ready():
	StaticSystemScript.player = self
	Engine.max_fps = 144


func _process(_delta):
	moving_direction = {
		right = int(Input.is_action_pressed("Movment_right_key")),
		left = int(Input.is_action_pressed("Movment_left_key")),
		up = int(Input.is_action_pressed("Movment_up_key")),
		down = int(Input.is_action_pressed("Movment_down_key")),
		run = int(Input.is_action_pressed("Movment_run_key"))}
	animate_sprite()
	play_sound_effects()
	


func _physics_process(_delta):
	if movement_blocker:
		move_and_slide()
		moving_vector = Vector2i(moving_direction.right - moving_direction.left,moving_direction.down - moving_direction.up)
		if moving_direction.run == 1: #and !InventorySystem.inventory_oppened
			speed = running_speed
		else:
			speed = walking_speed
		velocity = moving_vector.normalized() * speed


var state = "Idle"
var direction = "down"
func animate_sprite():
	if moving_vector == Vector2(0,0):
		state = "Idle"
	elif moving_direction.run == 0:
		state = "Walk"
	elif moving_direction.run == 1:
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
func can_move(_state : bool):
	movement_blocker = _state
	if !movement_blocker:
		animation_player.play("Idle" + "_" + direction)
		moving_vector = Vector2i(0,0)


func _input(_event):
	if Input.is_action_just_pressed("Debug_key"):
		InventoryManager.add_item(InventoryManager.ply_inventory,Items.MANZANA,100)
	if Input.is_action_just_pressed("Inventory_action_key"):
		InventoryManager.set_visibility(!InventoryManager.get_visibility())


func play_sound_effects():
	if timer.is_stopped():
		timer.start()

const GRASS_RUNNING = preload("res://Audio/sound_effects/grass_running.wav")
const GRASS_WALKING = preload("res://Audio/sound_effects/grass_walking.wav")

func _on_timer_timeout():
	var pitch : int
	match moving_direction.run:
		0:
			pitch = randf_range(1.3,1.6)
		1:
			pitch = randf_range(1.8,2.2)
	if moving_vector != Vector2(0,0):
		audio_stream_player.pitch_scale = pitch
		audio_stream_player.play()
