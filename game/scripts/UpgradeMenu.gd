extends CanvasLayer

var base_tank_level = 0
var base_generator_level = 0
var base_turret_count = 1
var base_strength_level = 0
var base_armor_level = 0
var base_repair_level = 0

var ship_speed_level = 0
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
	pass # Replace with function body.
