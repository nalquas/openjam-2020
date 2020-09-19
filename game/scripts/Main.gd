extends Node

func _ready():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("fullscreen"):
		toggle_fullscreen()

func toggle_fullscreen():
	OS.window_fullscreen = !OS.window_fullscreen
