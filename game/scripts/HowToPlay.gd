extends CanvasLayer

signal howToBack

func get_main():
	# Get Main node
	var mains = get_tree().get_nodes_in_group("Main")
	if (not mains == null) and (mains.size() > 0):
		return mains[0]

func set_visible(state):
	$Title.visible = state
	$Label.visible = state
	$Label2.visible = state
	$Button.visible = state


func _ready():
	pass # Replace with function body.



func _on_Button_pressed():
	get_main().play_click()
	emit_signal("howToBack")
