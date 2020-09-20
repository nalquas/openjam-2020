tool
extends Control

export (int) var radius = 96
export (float) var outline = 2.0
export (Color) var background_color = Color("#000000")
export (Color) var player_color = Color("#00ff00")
export (Color) var oxygen_color = Color("#00aaff")
export (Color) var metal_color = Color("#ff9900")
export (Color) var enemy_color = Color("#ff0000")
export (Color) var outline_color = Color("#8c8c8c")

var relative_home_position = Vector2(0, 0)

func _draw():
	draw_circle(Vector2(0, 0), radius, background_color) # Background
	draw_circle(Vector2(0, 0), 1, player_color) # Center
	
	# Get Player position
	var players = get_tree().get_nodes_in_group("Player")
	if not players == null:
		var player_position = players[0].global_position
		
		# Oxygen clouds
		for node in get_tree().get_nodes_in_group("Oxygen"):
			draw_circle(magic_function(node.global_position - player_position), 1, oxygen_color)
		
		# Metal
		for node in get_tree().get_nodes_in_group("Metal"):
			draw_circle(magic_function(node.global_position - player_position), 1, oxygen_color)
		
		# Enemies (birds)
		for node in get_tree().get_nodes_in_group("Bird"):
			draw_circle(magic_function(node.global_position - player_position), 1, enemy_color)
	
	# Home
	draw_circle(relative_home_position, 3, player_color) # Relative home position
	
	draw_arc(Vector2(0, 0), radius, 0, 2*PI, 360, outline_color, outline, true) # Border

func refresh_home_position(relative_position):
	relative_home_position = magic_function(relative_position)

func magic_function(relative_position):
	var length = relative_position.length()
	var relative_position_converted = relative_position.normalized() * sqrt(length+0.1) * 0.66
	if relative_position_converted.length() >= radius - 3:
		relative_position_converted = relative_position_converted.normalized() * (radius - 3)
	return relative_position_converted
