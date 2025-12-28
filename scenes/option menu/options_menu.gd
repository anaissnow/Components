extends Control
class_name OptionsMenu

@onready var exit_menu_button: Button = $ExitMenuButton
@onready var sfx_player: AudioStreamPlayer = $SFX_Player


func _on_exit_menu_button_pressed() -> void:
	sfx_player.play()
	await sfx_player.finished
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
