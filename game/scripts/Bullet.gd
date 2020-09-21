extends Area2D

export (float) var speed = 3000.0
export (Vector2) var direction = Vector2(0.0, -1.0)

var seconds_remaining = 5.0

func _physics_process(delta):
	# Movement and collision
	position += direction.normalized() * speed * delta
	
	# Despawn timer
	seconds_remaining -= delta
	if seconds_remaining <= 0:
		queue_free()
