extends KinematicBody2D

export (float) var free_fly_speed = 175.0

export (AudioStream) var bird_dies
export (AudioStream) var bird_hit

var home = null # Configured by Bird spawner (metal)
var hits = 0
export var hp = 3
var paused = false
# Variables necessary for circling around the metal
var start_offset = 1.0
var time_offset = 0.0
var prev_position = position

var stay_home = true
var prefer_attacking_player = false

func _ready():
	# Use spawned position as start position
	start_offset = (position - home.global_position).angle()

func get_main():
	# Get Main node
	var mains = get_tree().get_nodes_in_group("Main")
	if (not mains == null) and (mains.size() > 0):
		return mains[0]

func _physics_process(delta):
	# Handle movement
	if not paused:
		if stay_home :
			if home != null:
				if home.is_inside_tree():
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
					# If chunk is removed, despawn
					queue_free()
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

func hit():
	hits += 1
	if hits >= hp:
		get_main().play_audio(bird_dies)
		queue_free()
	get_main().play_audio(bird_hit)

func toggle_pause():
	paused = not paused
	$AnimatedSprite.playing = not paused
