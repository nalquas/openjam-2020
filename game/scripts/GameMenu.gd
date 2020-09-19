extends CanvasLayer

signal menu

func _ready():
	set_visible(false)

func set_visible(state):
	$BackgroundBorder.visible = state
	$Background.visible = state
	$VBoxContainer.visible = state

func get_visible():
	return $VBoxContainer.visible

func _on_ButtonContinue_pressed():
	set_visible(false)

func _on_ButtonMenu_pressed():
	emit_signal("menu")
