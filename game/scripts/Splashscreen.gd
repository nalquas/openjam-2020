extends Node

var scene_main = preload("res://scenes/game/Main.tscn")
var seconds_remaining = 5.0

func _ready():
	$CanvasLayer/Fade.visible = true
	$CanvasLayer/Fade.color = Color("#ff4d4d4d") # Environment background color

func _input(event):
	# Allow skipping of splashscreen
	if event is InputEventKey or event is InputEventJoypadButton or event is InputEventMouseButton:
		# Skip                                                                                                                                                                    
		if not (event is InputEventKey and OS.get_scancode_string(event.scancode) == "F11"):
			seconds_remaining = 0

func _process(delta):
	# Handle Fullscreen toggle
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	# Timer
	seconds_remaining -= delta
	
	# Fade-in
	if seconds_remaining > 4.0:
		$CanvasLayer/Fade.color.a = seconds_remaining - 4.0
	elif seconds_remaining < 1.0:
		$CanvasLayer/Fade.color.a = 1.0 - seconds_remaining
	else:
		$CanvasLayer/Fade.color.a = 0.0
	
	if seconds_remaining <= 0:
		get_tree().change_scene_to(scene_main)
