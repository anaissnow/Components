extends CharacterBody3D

@export var stats : EnemyStats

func _physics_process(delta: float) -> void:
	velocity.x = stats.max_speed * delta
	velocity.x = stats.max_speed * delta * -1
	velocity.z = stats.max_speed * delta
	velocity.z = stats.max_speed * delta * -1
	move_and_slide()

func _process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += stats.GRAVITY * delta
		velocity.x = 0
		velocity.z = 0
		move(delta)

func move(delta):
	if stats.is_dead:
		if !stats.is_enemy_chase:
			velocity += stats.dir * stats.max_speed * delta
			stats.is_roaming = true
		elif !stats.is_dead:
			velocity.x = 0
