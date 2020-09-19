extends CanvasLayer

signal start
signal fullscreen
signal quit

func set_visible(state):
	$Title.visible = state
	$VBoxContainer.visible = state
	$Version.visible = state
	$Copyright.visible = state

func _on_ButtonStart_pressed():
	emit_signal("start")

func _on_ButtonFullscreen_pressed():
	emit_signal("fullscreen")

func _on_ButtonQuit_pressed():
	emit_signal("quit")
