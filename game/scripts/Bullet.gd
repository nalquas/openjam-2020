extends Area2D

export (float) var speed = 3000.0
export (Vector2) var direction = Vector2(0.0, -1.0)
var paused 
var seconds_remaining = 2.0

func _physics_process(delta):
	if not paused:
		position += direction.normalized() * speed * delta
		
		# Despawn timer
		seconds_remaining -= delta
		if seconds_remaining <= 0:
			queue_free()


func _on_Bullet_body_entered(body):
	if body.is_in_group("Bird"):
		body.hit()
		queue_free()
func toggle_pause():
	paused = not paused
	if paused:
		$CPUParticles2D.speed_scale=0
	else:
		$CPUParticles2D.speed_scale=8
