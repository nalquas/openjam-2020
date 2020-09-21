extends CanvasLayer

signal start
signal fullscreen
signal quit
signal toggleMusic

func set_visible(state):
	$Title.visible = state
	$VBoxContainer.visible = state
	$Version.visible = state
	$Copyright.visible = state
	$Background.visible = state

func get_main():
	# Get Main node
	var mains = get_tree().get_nodes_in_group("Main")
	if (not mains == null) and (mains.size() > 0):
		return mains[0]

func _on_ButtonStart_pressed():
	get_main().play_click()
	emit_signal("start")

func _on_ButtonFullscreen_pressed():
	get_main().play_click()
	emit_signal("fullscreen")

func _on_ButtonQuit_pressed():
	get_main().play_click()
	emit_signal("quit")


func _on_ButtonMusic_pressed():
	get_main().play_click()
	emit_signal("toggleMusic")
