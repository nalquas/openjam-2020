extends Node

export (PackedScene) var scene_game
export (PackedScene) var scene_audioplayer

func _ready():
	$MainMenu.set_visible(true)

func _process(_delta):
	if Input.is_action_just_pressed("fullscreen"):
		toggle_fullscreen()

func toggle_fullscreen():
	OS.window_fullscreen = !OS.window_fullscreen

func play_audio(audio, loop=false, volume_db=0, title="none"):
	var ap = scene_audioplayer.instance()
	ap.setAudio(audio, volume_db)
	ap.loop = loop
	ap.title = title
	add_child(ap)

func _on_MainMenu_start():
	$MainMenu.set_visible(false)
	
	# Start game
	var game_instance = scene_game.instance()
	call_deferred("add_child", game_instance)

func _on_MainMenu_fullscreen():
	toggle_fullscreen()

func _on_Game_menu():
	$MainMenu.set_visible(true)

func _on_MainMenu_quit():
	# Quit application
	get_tree().quit()
