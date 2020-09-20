extends KinematicBody2D


var following = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	if following:
		var distance = position.distance_to(get_tree().get_nodes_in_group("Player")[0].position)
		move_and_slide(get_tree().get_nodes_in_group("Player")[0].position - position)

func follow():
	following = !following
