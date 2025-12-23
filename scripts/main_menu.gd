extends Control


@onready var play_button: Button = $VBoxContainer/PlayButton
@onready var option_button: Button = $VBoxContainer/OptionButton
@onready var quit_button: Button = $VBoxContainer/QuitButton
@onready var start_level = preload("res://scenes/main.tscn")
@onready var options_menu = preload("res://scenes/option menu/option_menu.tscn")


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)


func _on_option_button_pressed() -> void:
	get_tree().change_scene_to_packed(options_menu)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
