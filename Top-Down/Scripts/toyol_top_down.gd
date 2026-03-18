extends CharacterBody2D
class_name ToyolEnemy

@export var blue = Color.STEEL_BLUE
@export var green = Color.SEA_GREEN
@export var red = Color.PALE_VIOLET_RED

const speed : float = 20.0
var dir: Vector2

var is_toyol_chase: bool
var player

@onready var prompt = $RichTextLabel
@onready var prompt_text = prompt.text
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	prompt_text = PromptList.get_prompt()
	prompt.parse_bbcode(set_center_tags(prompt_text))
	is_toyol_chase = true

func get_prompt() -> String:
	return prompt_text.to_lower()

func _physics_process(delta: float) -> void:	
	move(delta)
	handle_animation()

func set_next_character(next_character_index: int):
	var blue_text = get_bbcode_color_tag(blue) + prompt_text.substr(0, next_character_index) + get_bbcode_end_color_tag()
	var green_text = get_bbcode_color_tag(green) + prompt_text.substr(next_character_index, 1) + get_bbcode_end_color_tag()
	var red_text = ""
	if next_character_index != prompt_text.length():
		red_text = get_bbcode_color_tag(red) + prompt_text.substr(next_character_index + 1, prompt_text.length() - next_character_index + 1) + get_bbcode_end_color_tag()
	prompt.parse_bbcode(set_center_tags(blue_text + green_text + red_text))

func set_center_tags(string_to_center: String):
	return "[center]" + string_to_center + "[/center]"

func get_bbcode_color_tag(color: Color) -> String:
	return "[color=#" + color.to_html(false) + "]"

func get_bbcode_end_color_tag() -> String:
	return "[/color]"

func move(delta):
	if is_toyol_chase:
		player = GlobalSignals.playerBody
		velocity = position.direction_to(player.position) * speed
		dir.x = abs(velocity.x) / velocity.x
	elif !is_toyol_chase:
		velocity += dir * speed * delta
	move_and_slide()

func handle_animation():
	animated_sprite_2d.play("walking")
	if velocity.x > 1:
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false

func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([2.0, 2.5, 3.0])
	if !is_toyol_chase:
		dir = choose([Vector2.RIGHT, Vector2.DOWN, Vector2.UP, Vector2.LEFT])

func choose(array):
	array.shuffle()
	return array.front()
