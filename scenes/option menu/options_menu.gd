extends Control
class_name OptionsMenu

@onready var exit_menu_button: Button = $ExitMenuButton
@onready var title_screen = preload("res://scenes/main_menu.tscn")


func _on_exit_menu_button_pressed() -> void:
	get_tree().change_scene_to_packed(title_screen)
