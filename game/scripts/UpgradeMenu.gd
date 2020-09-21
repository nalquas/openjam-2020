extends CanvasLayer

var base_tank_level = 0
var base_generator_level = 0
var base_turret_count = 1
var base_strength_level = 0
var base_armor_level = 0
var base_repair_level = 0

var ship_speed_level = 1
var ship_oxygen_level = 0
var ship_fuel_level = 0
var ship_strength_level = 0

var metal = 0
var oxygen = 0

func set_visible(state):
	$Background.visible = state
	$UpgradeMenuTitle.visible = state
	$UpgradeList.visible = state
	$StatusLabel.visible = state

func refresh(oxygen, metal):
	self.metal = metal
	self.oxygen = oxygen
	$StatusLabel.text = "Remaining Oxygen: " + String(oxygen) + "\nRemaining Metal: " + String(metal)

func _on_UpgradeList_item_activated(index):
	# Get Player
	var player
	var players = get_tree().get_nodes_in_group("Player")
	if (not players == null) and (players.size() > 0):
		player = players[0]
	
	# Get Homebase
	var homebase
	var homebases = get_tree().get_nodes_in_group("Homebase")
	if (not homebases == null) and (homebases.size() > 0):
		homebase = homebases[0]
	
	match index:
		0:
			# Base - Oxygen Capacity
			pass
		1:
			# Base - Oxygen Generator
			pass
		2:
			# Base - Additional Turret
			pass
		3:
			# Base - Turret Strength
			pass
		4:
			# Base - Armor
			pass
		5:
			# Base - Repair Crew
			pass
		6:
			if ship_speed_level < 3:
				# Ship  - Speed
				ship_speed_level += 1
				player.set_engine_level(ship_speed_level)
				
				# Don't allow upgrades over level 3
				if ship_speed_level >= 3:
					$UpgradeList.set_item_disabled(6, true)
					$UpgradeList.set_item_selectable(6, false)
					$UpgradeList.unselect(6)
		7:
			# Ship  - Oxygen Capacity
			pass
		8:
			# Ship  - Fuel Tank Size
			pass
		9:
			# Ship  - Weapon Strength
			pass
