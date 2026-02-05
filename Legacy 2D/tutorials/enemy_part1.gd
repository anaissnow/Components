extends Sprite2D # Godot version 3.x MIGHT BE OUTDATED A LOT OF TIMES

@onready var prompt = $RichTextLabel
@onready var prompt_text = prompt.text

func get_prompt() -> String:
	return prompt_text.to_lower()
