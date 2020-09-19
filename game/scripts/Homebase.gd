extends Node2D

func set_camera(state):
	$Camera2D.current = state

func _on_Area_Outer_body_entered(body):
	# Handle collision with physics body
	print(String(body.name) + " entered Area_Outer of Homebase.")

func _on_Area_Outer_body_exited(body):
	# Handle collision with physics body
	print(String(body.name) + " exited Area_Outer of Homebase.")

func _on_Area_Hangar_body_entered(body):
	# Handle collision with physics body
	print(String(body.name) + " entered Area_Hangar of Homebase.")
	if body.name == "Player":
		set_camera(true)
		body.set_camera(false)

func _on_Area_Hangar_body_exited(body):
	# Handle collision with physics body
	print(String(body.name) + " exited Area_Hangar of Homebase.")
	if body.name == "Player":
		set_camera(false)
		body.set_camera(true)
