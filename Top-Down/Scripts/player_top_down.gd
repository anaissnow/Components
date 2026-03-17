extends CharacterBody2D

@export var speed : int = 150
@onready var animated_sprite_2d : AnimatedSprite2D = $AnimatedSprite2D

var dir
var main_sm: LimboHSM

func _ready() -> void:
	initiate_state_machine()

func get_input():
	var input_direction := Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	# flipping animation horizontally
	if input_direction:
		if velocity.x >= 1:
			animated_sprite_2d.flip_h = true
		elif velocity.x <= 1:
			animated_sprite_2d.flip_h = false

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()

func initiate_state_machine():
	main_sm = LimboHSM.new() # create new file/resource
	add_child(main_sm)
	
	var idle_state = LimboState.new().named("idle").call_on_enter(idle_start).call_on_update(idle_update)
	var walk_state = LimboState.new().named("walk").call_on_enter(walk_start).call_on_update(walk_update)
	var attack_state = LimboState.new().named("attack").call_on_enter(attack_start).call_on_update(attack_update)
	
	main_sm.add_child(idle_state)
	main_sm.add_child(walk_state)
	main_sm.add_child(attack_state)
	
	main_sm.initial_state = idle_state
	
	main_sm.add_transition(idle_state, walk_state, &"to_walk")
	main_sm.add_transition(main_sm.ANYSTATE, idle_state, &"state_ended")
	main_sm.add_transition(main_sm.ANYSTATE, attack_state, &"to_attack")
	
	main_sm.initialize(self)
	main_sm.set_active(true)

func idle_start():
	animated_sprite_2d.play("idle")

func idle_update(delta: float):
	if velocity.x != 0:
		main_sm.dispatch(&"to_walk")

func walk_start():
	animated_sprite_2d.play("walking")

func walk_update(delta: float):
	if velocity.x == 0:
		main_sm.dispatch(&"state_ended")

func attack_start():
	pass

func attack_update(delta: float):
	pass
