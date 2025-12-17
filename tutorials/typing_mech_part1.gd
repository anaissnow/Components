extends Node2D

@onready var enemy_container = $EnemyContainer
var active_enemy = null
var current_letter_index : int = -1

func find_new_active_enemy(typed_character: String):
	for enemy in enemy_container.get_children():
		var prompt = enemy.get_prompt()
		var next_character = prompt.substr(0,1)
		if next_character == typed_character:
			print("found new enemy that starts with: ", next_character)
			active_enemy = enemy
			current_letter_index = 1

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
				if current_letter_index == prompt.length():
					print("done!")
					current_letter_index = -1
					active_enemy.queue_free()
					active_enemy = null
			else:
				print("incorrectly typed: ", key_typed, " instead of: ", next_character)
