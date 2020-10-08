extends Node

export (PackedScene) var scene_game
export (PackedScene) var scene_audioplayer

export (AudioStream) var main_track
export (AudioStream) var click_sound

var music_playing = true

func _ready():
	play_audio(main_track, true, -7, "music")
	$CreditsPage.set_visible(false)
	$MainMenu.set_visible(true)
	$GameOverScreen.set_visible(false)
	$HowToPlay.set_visible(false)

func _process(_delta):
	if Input.is_action_just_pressed("fullscreen"):
		toggle_fullscreen()
	if Input.is_action_just_pressed("screenshot"):
		get_viewport().set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
		yield(VisualServer, "frame_post_draw")
		var img = get_viewport().get_texture().get_data()
		img.flip_y()
		img.save_png("res://screenshots/test.png")
		print("image saved")

func toggle_fullscreen():
	OS.window_fullscreen = !OS.window_fullscreen

func play_audio(audio, loop=false, volume_db=0, title="none"):
	var ap = scene_audioplayer.instance()
	ap.setAudio(audio, volume_db)
	ap.loop = loop
	ap.title = title
	add_child(ap)

func stopAudio(title, fade=false):
	for ap in get_tree().get_nodes_in_group("AudioPlayer"):
		if ap.title == title:
			ap.despawn(fade)

func play_click():
	var ap = scene_audioplayer.instance()
	ap.setAudio(click_sound, 5)
	ap.loop = false
	ap.title = ""
	add_child(ap)

func game_over(reason):
	$GameOverScreen.set_visible(true)
	$MainMenu/Background.visible = true
	$GameOverScreen/Reason.text = reason
	

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
	if music_playing:
		stopAudio("music", false)
		music_playing = false
	else:
		play_audio(main_track, true, -7, "music")
		music_playing = true


func _on_MainMenu_openCredits():
	$MainMenu.set_visible(false)
	$MainMenu/Background.set_visible(true)
	$CreditsPage.set_visible(true)


func _on_CreditsPage_back():
	$CreditsPage.set_visible(false)
	$MainMenu.set_visible(true)


func _on_GameOverScreen_gameoverback():
	$GameOverScreen.set_visible(false)
	$MainMenu.set_visible(true)


func _on_HowToPlay_howToBack():
	$HowToPlay.set_visible(false)
	$MainMenu.set_visible(true)


func _on_MainMenu_howTo():
	$HowToPlay.set_visible(true)
	$MainMenu.set_visible(false)
	$MainMenu/Background.visible = true
