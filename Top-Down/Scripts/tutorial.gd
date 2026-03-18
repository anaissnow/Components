extends Node2D

@onready var spawn_container: Node2D = $SpawnContainer
@onready var enemy_container: Node2D = $EnemyContainer
@onready var spawn_timer: Timer = $SpawnTimer

var current_wave: int
@export var toyol_scene: PackedScene

var starting_nodes: int
var current_nodes: int
var wave_spawn_ended

var Toyol = preload("uid://6lgp7blcr621")

var active_enemy = null
var current_letter_index: int = -1

func _ready() -> void:
	randomize()
	spawn_timer.start()
	spawn_enemy()
	current_wave = 0
	GlobalSignals.current_wave = current_wave
	starting_nodes = get_child_count()
	current_nodes = get_child_count()

func find_new_active_enemy(typed_character: String):
	for enemy in enemy_container.get_children():
		var prompt = enemy.get_prompt()
		var next_character = prompt.substr(0,1)
		if next_character == typed_character:
			print("found new enemy that starts with: ", next_character)
			active_enemy = enemy
			current_letter_index = 1
			active_enemy.set_next_character(current_letter_index)
			return

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and !event.is_echo():
		var typed_event = event as InputEventKey
		var cp : int = typed_event.unicode
		if cp == 0:
			return
		var key_typed = char(cp)
		
		if active_enemy == null:
			find_new_active_enemy(key_typed)
		else:
			var prompt = active_enemy.get_prompt()
			var next_character = prompt.substr(current_letter_index, 1)
			if key_typed == next_character:
				print("successfully typed: ", key_typed)
				current_letter_index += 1
				active_enemy.set_next_character(current_letter_index)
				if current_letter_index == prompt.length():
					print("done!")
					current_letter_index = -1
					active_enemy.queue_free()
					active_enemy = null
			else:
				print("incorrectly typed: ", key_typed, " instead of: ", next_character)

func _on_spawn_timer_timeout() -> void:
	spawn_enemy()

func spawn_enemy():
	var enemy_instance = Toyol.instantiate()
	var spawns = spawn_container.get_children()
	var index = randi() % spawns.size()
	enemy_instance.global_position = spawns[index].global_position
	enemy_container.add_child(enemy_instance)
