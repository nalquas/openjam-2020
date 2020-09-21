extends Node2D

export (PackedScene) var scene_bullet

var bird_direction = Vector2()
var bird_position = Vector2()

var tracked_bird
export (bool) var active = false

var time_since_last_shot = 1

func _ready():
	set_active(active)

func _physics_process(delta):
	if active:
		time_since_last_shot += delta
		if time_since_last_shot > 1:
			time_since_last_shot = 0
			var overlapping_bodies = $Bird_Detector.get_overlapping_bodies()
			var distance = 10000
			for x in overlapping_bodies:
				if x.is_in_group("Bird"):
					if x.position.distance_to(position) < distance:
						distance = x.position.distance_to(position)
						tracked_bird = x
			if tracked_bird != null:
				bird_direction = tracked_bird.global_position - position
				look_at(tracked_bird.global_position)
				shoot()

func shoot():
	var new_bullet = scene_bullet.instance()
	new_bullet.position = $Barrel.global_position
	new_bullet.direction = bird_direction
	new_bullet.rotation = rotation
	get_parent().add_child(new_bullet)

func set_active(state):
	visible = state
	active = state
