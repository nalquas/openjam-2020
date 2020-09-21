extends Node

export (PackedScene) var scene_game
export (PackedScene) var scene_audioplayer

export (AudioStream) var main_track
export (AudioStream) var click_sound

var mp

func _ready():
	mp = scene_audioplayer.instance()
	mp.setAudio(main_track, -5)
	mp.loop = true
	mp.title = ""
	add_child(mp)
	$CreditsPage.set_visible(false)
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

func play_click():
	var ap = scene_audioplayer.instance()
	ap.setAudio(click_sound, 5)
	ap.loop = false
	ap.title = ""
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


func _on_MainMenu_toggleMusic():
	if mp != null:
		mp.despawn()
	if mp == null:
		mp = scene_audioplayer.instance()
		mp.setAudio(main_track, -5)
		mp.loop = true
		mp.title = ""
		add_child(mp)


func _on_MainMenu_openCredits():
	$MainMenu.set_visible(false)
	$MainMenu/Background.set_visible(true)
	$CreditsPage.set_visible(true)


func _on_CreditsPage_back():
	$CreditsPage.set_visible(false)
	$MainMenu.set_visible(true)
