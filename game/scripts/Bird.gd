extends KinematicBody2D

var home = null # Configured by Bird spawner (metal)

# Variables necessary for circling around the metal
var start_offset = 1.0
var time_offset = 0.0
var prev_position = position

var stay_home = true

func _ready():
	# Use spawned position as start position
	start_offset = (position - home.global_position).angle()

func _physics_process(delta):
	# Despawn if home is gone
	# TODO: If the home is metal and is gone because it has been collected,
	# redirect the birds at the player's homebase instead.
	if home == null:
		queue_free()
	else:
		if stay_home:
			# Handle movement
			# Circle around home
			time_offset += delta
			position = home.global_position + Vector2(
				192.0 * cos(start_offset + 2*PI + time_offset),
				192.0 * sin(start_offset + 2*PI + time_offset)
			)
			
			# Handle rotation
			rotation = (position - prev_position).angle()
			prev_position = position
		else:
			pass
