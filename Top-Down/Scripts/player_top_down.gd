extends CharacterBody2D

@export var speed : int = 150
@onready var animated_sprite_2d : AnimatedSprite2D = $AnimatedSprite2D


func get_input():
	var input_direction := Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	if input_direction:
		if velocity.x >= 1:
			animated_sprite_2d.flip_h = true
			animated_sprite_2d.play("walking")
		if velocity.x <= 1:
			animated_sprite_2d.flip_h = false
			animated_sprite_2d.play("walking")
	print(input_direction)

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
