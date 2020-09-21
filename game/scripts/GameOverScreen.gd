extends CanvasLayer

signal gameoverback

func _ready():
	pass # Replace with function body.

func set_visible(state):
	$Title.visible = state
	$ButtonBack.visible = state
	$Reason.visible = state


func get_main():
	# Get Main node
	var mains = get_tree().get_nodes_in_group("Main")
	if (not mains == null) and (mains.size() > 0):
		return mains[0]


func _on_ButtonBack_pressed():
	get_main().play_click()
	emit_signal("gameoverback")

