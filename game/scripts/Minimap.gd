tool
extends Control

export (int) var radius = 96
export (float) var outline = 2.0
export (Color) var background_color = Color("#222034")
export (Color) var player_color = Color("#00ff00")

var relative_home_position = Vector2(0, 0)

func _draw():
	draw_circle(Vector2(0, 0), radius, background_color) # Background
	draw_circle(Vector2(0, 0), 1, player_color) # Center
	draw_circle(relative_home_position, 3, player_color) # Relative home position
	draw_arc(Vector2(0, 0), radius, 0, 2*PI, 360, Color("#ffffff"), outline, true) # Border

func refresh_home_position(relative_position):
	var length = relative_position.length()
	relative_home_position = relative_position.normalized() * sqrt(length+0.1) * 0.66
	if relative_home_position.length() >= radius - 3:
		relative_home_position = relative_home_position.normalized() * (radius - 3)
	update()
