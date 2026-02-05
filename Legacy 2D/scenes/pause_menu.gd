extends Control

@onready var game_level = preload("uid://knkdex3148md")

func resume():
	self.hide()


func pause():
	get_tree().paused = true


func _on_main_menu_button_pressed() -> void:
	AudioController.play_button_sfx()
	get_tree().paused = false
	get_tree().change_scene_to_file("uid://sb4kjeceuvh7")


func _on_restart_button_pressed() -> void:
	AudioController.play_button_sfx()
	get_tree().paused = false
	get_tree().call_deferred("reload_current_scene")


func _on_resume_button_pressed() -> void:
	AudioController.play_button_sfx()
	resume()
	get_tree().paused = false
