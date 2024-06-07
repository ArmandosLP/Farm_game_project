extends StaticBody2D
class_name Rock

@onready var cpu_particles_2d = %CPUParticles2D
@onready var sprite_2d = %Sprite2D
@onready var timer = %Timer

var health : int = 1
@export var item:Item


func tool_interaction(_tool):
	health -= 1
	if health <= 0:
		destroy()


func destroy():
	sprite_2d.visible = false
	cpu_particles_2d.emitting = true
	InventoryManager.spawn_item(item,1,position,true)
	timer.start()


func _on_timer_timeout():
	queue_free()

