extends Resource
class_name EnemyStats


@export var max_health : float
@export var min_health : float
@export var damage_dealt : int
@export var max_speed : float

var damage_taken : bool = false
var is_enemy_chase : bool = false
var is_dead : bool = false
var is_roaming : bool = true
var is_dealing_damage : bool = false
var dir : Vector3
var dir_right = Vector3(1,0,0)
var dir_left = Vector3(-1,0,0)
const GRAVITY = 900
