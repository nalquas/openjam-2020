extends CanvasLayer

signal back

func set_visible(state):
	$Title.visible = state
	$ButtonBack.visible = state
	$Text.visible = state
	$Text2.visible = state

func get_main():
	# Get Main node
	var mains = get_tree().get_nodes_in_group("Main")
	if (not mains == null) and (mains.size() > 0):
		return mains[0]

func _on_ButtonBack_pressed():
	get_main().play_click()
	emit_signal("back")
