extends KinematicBody2D
var home = null

# Declare member variables here. Examples:
# var a = 2
var dir = Vector2(1,0)
export (Vector2) var  homecoord


func _ready():
	pass # Replace with function body.


func _process(delta):
	if home == null:
		queue_free()
	if home != null and home.is_inside_tree():
		var rel_pos = home.global_position - self.global_position 
		var mov = Vector2(0,0)
		if rel_pos.x*rel_pos.y>=0:
			mov = Vector2(rel_pos.y,-rel_pos.x).normalized()
		else:
			mov = Vector2(-rel_pos.y,rel_pos.x).normalized()
		move_and_slide(mov*100)
