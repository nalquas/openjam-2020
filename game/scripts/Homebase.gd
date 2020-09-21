extends Node2D

export (int) var hp = 250
export (int) var hp_max = 250
export (PackedScene) var bird

var spawns_p_min = 2.0
var metal = 0
var oxygen = 50
var oxygen_max = 50
var paused = false
var elapsed = 0.0

var oxygen_level = 1
var oxygen_generator_level = 1
var turret_count = 1
var armor_level = 1
var repair_level = 1

func _ready():
	set_oxygen_level(1)
	set_oxygen_generator_level(1)
	set_turret_count(1)
	set_armor_level(1)
	set_repair_level(1)

func _process(delta):
	oxygen -= delta * 0.5/oxygen_generator_level
	if not paused:
		elapsed = elapsed + delta
		if elapsed>60/spawns_p_min:
			print(elapsed)
			elapsed = 0.0
			print(elapsed)
			spawns_p_min += 0.1/spawns_p_min
			var nb = bird.instance()
			nb.position=Vector2(0,2000+200*randf()).rotated(PI*2*randf())
			self.add_child(nb)

func set_camera(state):
	$Camera2D.current = state

func _on_Area_Outer_body_entered(body):
	# Handle collision with physics body
	if body.is_in_group("Metal"):
		body.collected()

func _on_Area_Outer_body_exited(body):
	# Handle collision with physics body
	pass

func _on_Area_Hangar_body_entered(body):
	# Handle collision with physics body
	if body.is_in_group("Player"):
		set_camera(true)
		body.set_camera(false)
		var landing_position = $LandingPosition1.global_position
		if randf() < 0.5:
			landing_position = $LandingPosition2.global_position
		body.land(landing_position)
		oxygen += body.oxygen
		body.oxygen = 0
		if oxygen > oxygen_max * oxygen_level:
			oxygen = oxygen_max * oxygen_level

func _on_Area_Hangar_body_exited(body):
	# Handle collision with physics body
	if body.is_in_group("Player"):
		set_camera(false)
		body.set_camera(true)

func toggle_pause():
	paused = not paused
	if paused:
		$AnimationPlayer.stop(false)
	else:
		$AnimationPlayer.play()

func set_oxygen_level(level):
	oxygen_level = level
	$Base/Oxy1.visible = false
	$Base/Oxy2.visible = false
	$Base/Oxy3.visible = false
	$Base/Oxy4.visible = false
	if level == 1:
		$Base/Oxy1.visible = true
	if level == 2:
		$Base/Oxy2.visible = true
	if level == 3:
		$Base/Oxy3.visible = true
	if level == 4:
		$Base/Oxy4.visible = true

func set_oxygen_generator_level(level):
	oxygen_generator_level = level
	$Base/Bridge1.visible = false
	$Base/Bridge2.visible = false
	$Base/Bridge3.visible = false
	$Base/Bridge4.visible = false
	if level == 1:
		$Base/Bridge1.visible = true
	if level == 2:
		$Base/Bridge2.visible = true
	if level == 3:
		$Base/Bridge3.visible = true
	if level == 4:
		$Base/Bridge4.visible = true

func set_turret_count(level):
	turret_count = level
	$Turret2.set_active(false)
	$Turret3.set_active(false)
	$Turret4.set_active(false)
	$Turret5.set_active(false)
	$Turret6.set_active(false)
	if level >= 2:
		$Turret2.set_active(true)
	if level >= 3:
		$Turret3.set_active(true)
	if level >= 4:
		$Turret4.set_active(true)
	if level >= 5:
		$Turret5.set_active(true)
	if level >= 6:
		$Turret6.set_active(true)

func set_armor_level(level):
	armor_level = level
	$Base/Shield1.visible = false
	$Base/Shield2.visible = false
	$Base/Shield3.visible = false
	if level == 1:
		$Base/Shield1.visible = true
	if level == 2:
		$Base/Shield2.visible = true
	if level == 3:
		$Base/Shield3.visible = true

func set_repair_level(level):
	repair_level = level
	$Base/Towers2.visible = false
	if level == 2:
		$Base/Towers2.visible = true
