extends Node2D

func _on_Area_Outer_body_entered(body):
	# Handle collision with physics body
	print(String(body.name) + " entered Area_Outer of Homebase.")

func _on_Area_Hangar_body_entered(body):
	# Handle collision with physics body
	print(String(body.name) + " entered Area_Hangar of Homebase.")
