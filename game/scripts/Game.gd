extends Node

signal menu

func _ready():
	connect("menu", get_parent(), "_on_Game_menu")
	$UpgradeMenu.set_visible(false)

func _process(_delta):
	# Handle menu toggle
	$p_cloud_map.player_coord = $Player.position
	if Input.is_action_just_pressed("menu"):
		$GameMenu.set_visible(!$GameMenu.get_visible())
	
	# Update minimap
	$GameOverlay/Minimap.refresh_home_position($Homebase.position - $Player.position)
	$GameOverlay/Minimap.update()
	
	# Update GUI progress bars
	$GameOverlay.set_health((float($Player.hp) / float($Player.hp_max)) * 100.0)
	$GameOverlay.set_fuel((float($Player.fuel) / float($Player.fuel_max)) * 100.0)
	$GameOverlay.set_ammo((float($Player.ammo) / float($Player.ammo_max)) * 100.0)
	$GameOverlay.set_oxygen((float($Player.oxygen) / float($Player.oxygen_max)) * 100.0)

func _on_GameMenu_menu():
	emit_signal("menu")
	queue_free()

func _on_Player_landing():
	$UpgradeMenu.set_visible(true)

func _on_Player_liftoff():
	$UpgradeMenu.set_visible(false)
