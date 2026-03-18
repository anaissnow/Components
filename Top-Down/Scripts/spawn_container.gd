extends Node2D

@onready var tutorial: Node2D = $".."
var toyol_scene := preload("uid://6lgp7blcr621")
var spawn_points := []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)

func _on_spawn_timer_timeout() -> void:
	# pick random spawn point
	var spawn = spawn_points[randi() % spawn_points.size()]
	# spawn enemy
	var toyol = toyol_scene.instantiate()
	toyol.position = spawn.position
	tutorial.add_child(toyol)
