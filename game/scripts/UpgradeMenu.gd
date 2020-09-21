extends CanvasLayer

export (AudioStream) var audio_success
export (AudioStream) var audio_not_enough_metal

var base_tank_level = 1
var base_generator_level = 1
var base_turret_count = 1
var base_strength_level = 1
var base_armor_level = 1
var base_repair_level = 1

var ship_speed_level = 1
var ship_oxygen_level = 1
var ship_fuel_level = 1
var ship_strength_level = 1

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
			if base_tank_level < 4:
				var dewit = false
				
				if base_tank_level == 1 and metal >= 30:
					metal -= 30
					dewit = true
				elif base_tank_level == 2 and metal >= 50:
					metal -= 50
					dewit = true
				elif base_tank_level == 3 and metal >= 70:
					metal -= 70
					dewit = true
				
				if dewit:
					play_success()
					
					# Ship  - Speed
					base_tank_level += 1
					homebase.set_oxygen_level(base_tank_level)
					
					if base_tank_level == 2:
						$UpgradeList.set_item_text(index, "Base - Oxygen Capacity 3 (50 Metal)")
					if base_tank_level == 3:
						$UpgradeList.set_item_text(index, "Base - Oxygen Capacity 4 (70 Metal)")
					elif base_tank_level >= 4:
						# Don't allow upgrades over level 4
						$UpgradeList.set_item_disabled(index, true)
						$UpgradeList.set_item_selectable(index, false)
						$UpgradeList.unselect(index)
						$UpgradeList.set_item_text(index, "Base - Oxygen Capacity (Maxed Out)")
				else:
					play_not_enough()
		1:
			# Base - Oxygen Generator
			if base_generator_level < 4:
				var dewit = false
				
				if base_generator_level == 1 and metal >= 30:
					metal -= 30
					dewit = true
				elif base_generator_level == 2 and metal >= 50:
					metal -= 50
					dewit = true
				elif base_generator_level == 3 and metal >= 70:
					metal -= 70
					dewit = true
				
				if dewit:
					play_success()
					
					# Ship  - Speed
					base_generator_level += 1
					homebase.set_oxygen_generator_level(base_generator_level)
					
					if base_generator_level == 2:
						$UpgradeList.set_item_text(index, "Base - Oxygen Generator 3 (50 Metal)")
					if base_generator_level == 3:
						$UpgradeList.set_item_text(index, "Base - Oxygen Generator 4 (70 Metal)")
					elif base_generator_level >= 4:
						# Don't allow upgrades over level 4
						$UpgradeList.set_item_disabled(index, true)
						$UpgradeList.set_item_selectable(index, false)
						$UpgradeList.unselect(index)
						$UpgradeList.set_item_text(index, "Base - Oxygen Generator (Maxed Out)")
				else:
					play_not_enough()
		2:
			# Base - Additional Turret
			if base_turret_count < 6:
				var dewit = false
				
				if base_turret_count == 1 and metal >= 40:
					metal -= 40
					dewit = true
				elif base_turret_count == 2 and metal >= 50:
					metal -= 50
					dewit = true
				elif base_turret_count == 3 and metal >= 60:
					metal -= 60
					dewit = true
				elif base_turret_count == 4 and metal >= 70:
					metal -= 70
					dewit = true
				elif base_turret_count == 5 and metal >= 80:
					metal -= 80
					dewit = true
				
				if dewit:
					play_success()
					
					# Ship  - Speed
					base_turret_count += 1
					homebase.set_turret_count(base_turret_count)
					
					if base_turret_count == 2:
						$UpgradeList.set_item_text(index, "Base - Turret Count 3 (50 Metal)")
					if base_turret_count == 3:
						$UpgradeList.set_item_text(index, "Base - Turret Count 4 (60 Metal)")
					if base_turret_count == 4:
						$UpgradeList.set_item_text(index, "Base - Turret Count 5 (70 Metal)")
					if base_turret_count == 5:
						$UpgradeList.set_item_text(index, "Base - Turret Count 6 (80 Metal)")
					elif base_turret_count >= 6:
						# Don't allow upgrades over level 6
						$UpgradeList.set_item_disabled(index, true)
						$UpgradeList.set_item_selectable(index, false)
						$UpgradeList.unselect(index)
						$UpgradeList.set_item_text(index, "Base - Oxygen Generator (Maxed Out)")
				else:
					play_not_enough()
		3:
			# Base - Armor
			if base_armor_level < 3:
				var dewit = false
				
				if base_armor_level == 1 and metal >= 50:
					metal -= 50
					dewit = true
				elif base_armor_level == 2 and metal >= 60:
					metal -= 60
					dewit = true
				
				if dewit:
					play_success()
					
					# Ship  - Speed
					base_armor_level += 1
					homebase.set_turret_count(base_armor_level)
					
					if base_armor_level == 2:
						$UpgradeList.set_item_text(index, "Base - Armor 3 (60 Metal)")
					elif base_armor_level >= 3:
						# Don't allow upgrades over level 3
						$UpgradeList.set_item_disabled(index, true)
						$UpgradeList.set_item_selectable(index, false)
						$UpgradeList.unselect(index)
						$UpgradeList.set_item_text(index, "Base - Armor (Maxed Out)")
				else:
					play_not_enough()
		4:
			# Base - Repair Crew
			if base_repair_level == 1:
				if metal >= 60:
					base_repair_level += 1
					play_success()
					metal -= 60
					homebase.set_repair_level(base_repair_level)
					
					# Don't allow further upgrades
					$UpgradeList.set_item_disabled(index, true)
					$UpgradeList.set_item_selectable(index, false)
					$UpgradeList.unselect(index)
					$UpgradeList.set_item_text(index, "Base - Repair Crew (Maxed Out)")
				else:
					play_not_enough()
		5:
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
						$UpgradeList.set_item_text(index, "Ship  - Speed 3 (50 Metal)")
					elif ship_speed_level >= 3:
						# Don't allow upgrades over level 3
						$UpgradeList.set_item_disabled(index, true)
						$UpgradeList.set_item_selectable(index, false)
						$UpgradeList.unselect(index)
						$UpgradeList.set_item_text(index, "Ship  - Speed (Maxed Out)")
				else:
					play_not_enough()
		6:
			# Ship  - Oxygen Capacity
			if ship_oxygen_level == 1:
				if metal >= 30:
					ship_oxygen_level += 1
					play_success()
					metal -= 30
					player.set_oxygentank_level(ship_oxygen_level)
					
					# Don't allow further upgrades
					$UpgradeList.set_item_disabled(index, true)
					$UpgradeList.set_item_selectable(index, false)
					$UpgradeList.unselect(index)
					$UpgradeList.set_item_text(index, "Ship  - Oxygen Capacity (Maxed Out)")
				else:
					play_not_enough()
		7:
			# Ship  - Fuel Tank Size
			if ship_fuel_level == 1:
				if metal >= 30:
					ship_fuel_level += 1
					play_success()
					metal -= 30
					player.set_fueltank_level(ship_fuel_level)
					
					# Don't allow further upgrades
					$UpgradeList.set_item_disabled(index, true)
					$UpgradeList.set_item_selectable(index, false)
					$UpgradeList.unselect(index)
					$UpgradeList.set_item_text(index, "Ship  - Fuel Tank Size (Maxed Out)")
				else:
					play_not_enough()
