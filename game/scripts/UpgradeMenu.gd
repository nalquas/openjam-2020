extends CanvasLayer

export (AudioStream) var audio_success
export (AudioStream) var audio_not_enough_metal

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

func get_main():
	# Get Main node
	var mains = get_tree().get_nodes_in_group("Main")
	if (not mains == null) and (mains.size() > 0):
		return mains[0]

func play_success():
	get_main().play_audio(audio_success)

func play_not_enough():
	get_main().play_audio(audio_not_enough_metal)

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
				var dewit = false
				
				if ship_speed_level == 1 and metal >= 30:
					metal -= 30
					dewit = true
				elif ship_speed_level == 2 and metal >= 50:
					metal -= 50
					dewit = true
				
				if dewit:
					play_success()
					
					# Ship  - Speed
					ship_speed_level += 1
					player.set_engine_level(ship_speed_level)
					
					if ship_speed_level == 2:
						$UpgradeList.set_item_text(6, "Ship  - Speed 3 (50 Metal)")
					elif ship_speed_level >= 3:
						# Don't allow upgrades over level 3
						$UpgradeList.set_item_disabled(6, true)
						$UpgradeList.set_item_selectable(6, false)
						$UpgradeList.unselect(6)
						$UpgradeList.set_item_text(6, "Ship  - Speed (Maxed Out)")
				else:
					play_not_enough()
		7:
			# Ship  - Oxygen Capacity
			pass
		8:
			# Ship  - Fuel Tank Size
			if ship_fuel_level == 1:
				if metal >= 30:
					play_success()
					metal -= 30
					player.set_fueltank_level(ship_fuel_level)
					
					# Don't allow further upgrades
					$UpgradeList.set_item_disabled(8, true)
					$UpgradeList.set_item_selectable(8, false)
					$UpgradeList.unselect(8)
					$UpgradeList.set_item_text(8, "Ship  - Fuel Tank Size (Maxed Out)")
				else:
					play_not_enough()
		9:
			# Ship  - Weapon Strength
			pass
