extends Node


signal difficulty_increased(new_difficulty)

var playerBody: CharacterBody2D

var current_wave: int
var moving_to_next_wave: bool
