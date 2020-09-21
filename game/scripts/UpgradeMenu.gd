extends CanvasLayer

func set_visible(state):
	$Background.visible = state
	$UpgradeMenuTitle.visible = state
	$UpgradeList.visible = state
	$StatusLabel.visible = state
