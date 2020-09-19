extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
var dir = Vector2(1,0)
export (Vector2) var  homecoord


func _ready():
	pass # Replace with function body.


func _process(delta):
	var average_pos = Vector2(0,0)
	var average_dir = Vector2(0,0)
	var average_move_away = Vector2(0,0)
	for bird in $view.get_overlapping_bodies():
		if bird.is_in_group("Bird"):
			var boid_dir = bird.position - self.position
			average_pos += boid_dir
			if boid_dir.length() < 200:
				average_move_away -= boid_dir
			average_dir += bird.dir
	dir = (average_pos.normalized()+average_dir.normalized() + average_move_away*3).normalized()
	move_and_slide(dir*75)
