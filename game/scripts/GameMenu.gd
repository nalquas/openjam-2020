extends CanvasLayer

signal menu

func _ready():
	set_visible(false)

func set_visible(state):
	$Background.visible = state
	$VBoxContainer.visible = state

func get_visible():
	return $VBoxContainer.visible

func _on_ButtonContinue_pressed():
	set_visible(false)
	for obj in get_tree().get_nodes_in_group("pausable"):
		obj.toggle_pause()

func _on_ButtonMenu_pressed():
	emit_signal("menu")
