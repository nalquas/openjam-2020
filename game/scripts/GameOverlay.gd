extends CanvasLayer

func set_health(percentage):
	$Health.value = clamp(percentage, 0.0, 100.0)

func set_fuel(percentage):
	$Fuel.value = clamp(percentage, 0.0, 100.0)

func set_ammo(percentage):
	$Ammo.value = clamp(percentage, 0.0, 100.0)

func set_oxygen(percentage):
	$Oxygen.value = clamp(percentage, 0.0, 100.0)
