extends Node2D

var metal = 0

func set_camera(state):
	$Camera2D.current = state

func _on_Area_Outer_body_entered(body):
	# Handle collision with physics body
	if body.is_in_group("Metal"):
		body.collected()

func _on_Area_Outer_body_exited(body):
	# Handle collision with physics body
	pass

func _on_Area_Hangar_body_entered(body):
	# Handle collision with physics body
	if body.is_in_group("Player"):
		set_camera(true)
		body.set_camera(false)
		var landing_position = $LandingPosition1.global_position
		if randf() < 0.5:
			landing_position = $LandingPosition2.global_position
		body.land(landing_position)

func _on_Area_Hangar_body_exited(body):
	# Handle collision with physics body
	if body.is_in_group("Player"):
		set_camera(false)
		body.set_camera(true)
