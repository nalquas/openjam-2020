extends KinematicBody2D

export (float) var speed = 500.0
export (Vector2) var direction = Vector2(0.0, -1.0) 

func _physics_process(delta):
	var collision = move_and_collide(direction * speed * delta)
	if collision:
		# TODO Handle collisions with objects
		queue_free() # Kill bullet
