extends Node

var word_list : Array[String] = []
var path = "res://resources/eng_words.txt"
var file = FileAccess.open(path, FileAccess.READ)
var content = file.get_as_text()

func _ready() -> void:
	if file == null:
		push_error("Could not open word file: " + path)
		return
	file.close()
	
	# Split into PackedStringArray
	var packed_words : PackedStringArray = content.split("\n", true)
	
	# Convert to Array[String]
	word_list.clear()
	for w in packed_words:
		word_list.append(w.strip_edges(true, true)) # trim white space
	
	# Optionally shuffle
	word_list.shuffle()


func get_prompt() -> String:
	var word_index = randi() % word_list.size()
	
	var word = word_list[word_index]
	
	return word
