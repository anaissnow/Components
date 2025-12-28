extends Control

@onready var game_level = preload("res://scenes/main.tscn")
@onready var sfx_player: AudioStreamPlayer = $SFX_Player

func resume():
	self.hide()


func pause():
	get_tree().paused = true


func _on_main_menu_button_pressed() -> void:
	sfx_player.play()
	await sfx_player.finished
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_restart_button_pressed() -> void:
	sfx_player.play()
	await sfx_player.finished
	get_tree().paused = false
	get_tree().call_deferred("reload_current_scene")


func _on_resume_button_pressed() -> void:
	sfx_player.play()
	await sfx_player.finished
	resume()
	get_tree().paused = false
