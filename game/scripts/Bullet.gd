extends KinematicBody2D

export (float) var speed = 3000.0
export (Vector2) var direction = Vector2(0.0, -1.0)

var seconds_remaining = 5.0

func _physics_process(delta):
	# Movement and collision
	var collision = move_and_collide(direction.normalized() * speed * delta)
	if collision:
		# TODO Handle collisions with objects
		queue_free() # Kill bullet
	
	# Despawn timer
	seconds_remaining -= delta
	if seconds_remaining <= 0:
		queue_free()
