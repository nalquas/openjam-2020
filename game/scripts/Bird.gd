extends KinematicBody2D

export (float) var free_fly_speed = 125.0

var home = null # Configured by Bird spawner (metal)

# Variables necessary for circling around the metal
var start_offset = 1.0
var time_offset = 0.0
var prev_position = position

var stay_home = true
var prefer_attacking_player = false

func _ready():
	# Use spawned position as start position
	start_offset = (position - home.global_position).angle()

func _physics_process(delta):
	# Handle movement
	if stay_home:
		if home != null:
			# Circle around home
			time_offset += delta
			position = home.global_position + Vector2(
				192.0 * cos(start_offset + 2*PI + time_offset),
				192.0 * sin(start_offset + 2*PI + time_offset)
			)
			
			# Stop staying at metal if it is taken by the player
			if home.following or home.collected:
				stay_home = false
		else:
			stay_home = false
	else:
		var target_direction = Vector2(0.0, 0.0)
		if prefer_attacking_player:
			# Attack player
			var players = get_tree().get_nodes_in_group("Player")
			if (not players == null) and (players.size() > 0):
				# Get Homebase position
				var player_position = players[0].global_position
				target_direction = player_position - position
		else:
			# Attack homebase
			var homebases = get_tree().get_nodes_in_group("Homebase")
			if (not homebases == null) and (homebases.size() > 0):
				# Get Homebase position
				var homebase_position = homebases[0].global_position
				target_direction = homebase_position - position
			
		move_and_slide(target_direction.normalized() * free_fly_speed)
	
	# Handle rotation
	if position != prev_position:
		rotation = (position - prev_position).angle()
	prev_position = position

func _on_AttackStartArea_body_entered(body):
	if body.is_in_group("Player"):
		stay_home = false
		prefer_attacking_player = true

func _on_AttackEndArea_body_exited(body):
	if body.is_in_group("Player"):
		prefer_attacking_player = false
