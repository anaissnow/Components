extends Control
class_name OptionsMenu

@onready var exit_menu_button: Button = $ExitMenuButton



func _on_exit_menu_button_pressed() -> void:
	AudioController.play_button_sfx()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
