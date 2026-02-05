extends Node2D

@export var mute: bool = false
@export_range(0, 10) var limit: int = 5 ## Maximum number of this SoundEffect to play simultaneously before culled.


var audio_count: int = 0 ## The instances of this [AudioStreamMP3] currently playing.


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not mute:
		play_music()

## Takes [param amount] to change the [member audio_count]. 
func change_audio_count(amount: int) -> void:
	audio_count = max(0, audio_count + amount)

## Checkes whether the audio limit is reached. Returns true if the [member audio_count] is less than the [member limit].
func has_open_limit() -> bool:
	return audio_count < limit

## Connected to the [member sound_effect]'s finished signal to decrement the [member audio_count].
func on_audio_finished() -> void:
	change_audio_count(-1)

func play_music() -> void:
	if not mute:
		$BGM.play()

func play_movement() -> void:
	if not mute:
		if has_open_limit():
			$Movement.play()
			audio_count += 1
			on_audio_finished()
			return

func play_button_sfx() -> void:
	if not mute:
		$ButtonSound.play()
		await $ButtonSound.finished

func play_end_level() -> void:
	if not mute:
		$BGM.stop()
		$EndLevel.play()
