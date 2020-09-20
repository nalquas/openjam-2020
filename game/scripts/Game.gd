extends Node

signal menu

func _ready():
	connect("menu", get_parent(), "_on_Game_menu")

func _process(_delta):
	# Handle menu toggle
	$p_cloud_map.player_coord = $Player.position
	if Input.is_action_just_pressed("menu"):
		$GameMenu.set_visible(!$GameMenu.get_visible())
	
	# Update minimap
	$GameOverlay/Minimap.refresh_home_position($Homebase.position - $Player.position)
	$GameOverlay/Minimap.update()
	
	# Update GUI progress bars
	$GameOverlay.set_health($Player.hp)
	$GameOverlay.set_fuel($Player.fuel)
	$GameOverlay.set_ammo($Player.ammo)
	$GameOverlay.set_oxygen($Player.oxygen)

func _on_GameMenu_menu():
	emit_signal("menu")
	queue_free()
