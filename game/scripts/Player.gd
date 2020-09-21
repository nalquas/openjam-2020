extends KinematicBody2D

signal landing
signal liftoff

export (PackedScene) var scene_bullet
export (AudioStream) var audio_shoot

export (Vector2) var direction = Vector2(0.0, -1.0)
export (float) var max_speed = 512.0
export (float) var acceleration = 21.0
export (float) var brake_factor = 0.98
export (int) var hp = 100
export (int) var hp_max = 100
export (float) var fuel = 50.0
export (float) var fuel_max = 50.0
export (float) var fuel_rate = 0.5
export (int) var oxygen = 0
export (int) var oxygen_max = 10
export (int) var ammo = 40
export (int) var ammo_max = 40
var speed = Vector2(0.0, 0.0)

var mouse_input_disabled = true
var mouse_vector = direction
var joy_input_disabled = true
var joy_vector = direction

var use_left_barrel = true
var landed = false
var landing_position = Vector2(0, 0)
var lifting_off = false
var paused = false
var tracked_metal

var engine_level = 1
var oxygen_tank_level = 1
var fueltank_level = 1

func _ready():
	set_engine_level(1)
	set_fueltank_level(1)

func get_main():
	# Get Main node
	var mains = get_tree().get_nodes_in_group("Main")
	if (not mains == null) and (mains.size() > 0):
		return mains[0]

func _input(event):
	# Mouse input events
	if event is InputEventMouseMotion or event is InputEventMouseButton:
		mouse_input_disabled = false
		joy_input_disabled = true
		mouse_vector = get_global_mouse_position() - position
	elif event is InputEventJoypadMotion:
		mouse_input_disabled = true
		joy_input_disabled = false

func _physics_process(delta):
	if not paused:
		if not landed:
			# Thrust
			var thrust = 0.0
			if Input.is_action_pressed("thrust"):
				thrust = 1.0
			if Input.is_action_pressed("boost"):
				thrust = 1.75
			
			# Asteroids-style directional input
			if Input.is_action_pressed("left"):
				direction = direction.rotated(-delta * 4.0)
				mouse_input_disabled = true
				joy_input_disabled = true
			if Input.is_action_pressed("right"):
				direction = direction.rotated(delta * 4.0)
				mouse_input_disabled = true
				joy_input_disabled = true
		
			# Controller-style input
			if not joy_input_disabled:
				# Get analog stick vectors
				var temp_direction_l = Vector2(Input.get_joy_axis(0, JOY_AXIS_0), Input.get_joy_axis(0, JOY_AXIS_1))
				var temp_direction_r = Vector2(Input.get_joy_axis(0, JOY_AXIS_2), Input.get_joy_axis(0, JOY_AXIS_3))
				
				# Apply deadzone (require the stick to be pressed by half or more)
				if temp_direction_l.length() > 0.70710678118: # sqrt(2)/2
					# Left stick: Point and thrust
					direction = temp_direction_l
					if thrust == 0.0:
						thrust = 1.0
				elif temp_direction_r.length() > 0.70710678118: # sqrt(2)/2
					# Right stick: Point, don't change thrust
					direction = temp_direction_r
			
			# Mouse-style input
			if not mouse_input_disabled:
				direction = mouse_vector
			
			# Finish movement
			rotation = direction.angle()
			if thrust > 0 and fuel > 0:
				# Deduct fuel spent
				if thrust == 1.0:
					fuel -= fuel_rate * delta * (1.0 / fueltank_level)
				elif thrust == 1.75:
					fuel -= fuel_rate * 2.25*delta * (1.0 / fueltank_level)
				
				# Multiply thrust based on engine_level
				if engine_level == 2:
					thrust = thrust * 1.25
				if engine_level == 3:
					thrust = thrust * 1.5
				
				# Thrusting
				speed += direction.normalized() * thrust * acceleration
				if speed.length() > max_speed * thrust:
					speed = speed.normalized() * max_speed * thrust
			else:
				# Braking
				speed = speed * brake_factor
				if speed.length() < 0.01:
					speed = Vector2(0.0, 0.0)
			move_and_slide(speed)
			
			# Shooting
			if Input.is_action_just_pressed("shoot") and ammo > 0:
				# Play shooting sound
				get_main().play_audio(audio_shoot)
				
				# Spawn and configure bullet
				var new_bullet = scene_bullet.instance()
				new_bullet.direction = direction
				new_bullet.rotation = direction.angle()
				if use_left_barrel:
					new_bullet.position = $LeftBarrel.global_position
				else:
					new_bullet.position = $RightBarrel.global_position
				use_left_barrel = !use_left_barrel
				get_parent().add_child(new_bullet)
			
				# Deduct ammo
				ammo -= 1
		
			# activating tractorbeam
			if Input.is_action_just_pressed("tractor_beam"):
				if tracked_metal != null:
					tracked_metal.follow()
				var overlapping_bodies = $TractorRadius.get_overlapping_bodies()
				var distance = 10000
				for x in overlapping_bodies:
					if x.is_in_group("Metal"):
						if x.position.distance_to(position) < distance:
							distance = x.position.distance_to(position)
							tracked_metal = x
				if tracked_metal != null:
					tracked_metal.follow()
		else:
			if not lifting_off:
				# Landing procedure
				var steps_complete = 0
				
				# Scale down
				if scale.x > 0.5:
					scale = scale * 0.99
				else:
					steps_complete += 1
				
				# Approach landing position
				if (position - landing_position).length() > 0.5:
					move_and_slide(2.0 * (landing_position - position))
				else:
					steps_complete += 1
				
				if steps_complete == 2:
					# Landed
					
					# Refill
					if ammo < ammo_max or fuel < fuel_max or hp < hp_max:
						ammo = ammo_max
						fuel = fuel_max
						hp = hp_max
					
					# Check for liftoff request
					if Input.is_action_just_pressed("menu") or Input.is_action_just_pressed("tractor_beam"):
						liftoff()
			else:
				# Liftoff
				if scale.x < 1.0:
					scale = scale * 1.05
				if scale.x > 1.0:
					scale = Vector2(1.0, 1.0)
					lifting_off = false
					landed = false

func set_camera(state):
	$Camera2D.current = state

func deal_damage(damage):
	hp -= damage
	if hp < 0:
		hp = 0

func add_oxygen():
	if oxygen < oxygen_max * oxygen_tank_level:
		oxygen += 1
		return true
	return false

func land(landing_pos):
	emit_signal("landing")
	landing_position = landing_pos
	landed = true
	speed = Vector2(0.0, 0.0)
	
	$LeftExhaust.emitting = false
	$CentralExhaust.emitting = false
	$RightExhaust.emitting = false

func toggle_pause():
	paused = not paused
	if paused:
		$CentralExhaust.speed_scale=0
		$LeftExhaust.speed_scale = 0
		$RightExhaust.speed_scale = 0
	else:
		$CentralExhaust.speed_scale=2.5
		$LeftExhaust.speed_scale = 2.5
		$RightExhaust.speed_scale = 2.5

func liftoff():
	emit_signal("liftoff")
	lifting_off = true
	$LeftExhaust.emitting = true
	$CentralExhaust.emitting = true
	$RightExhaust.emitting = true

func set_engine_level(level):
	engine_level = level
	$Base/Engine1.visible = false
	$Base/Engine2.visible = false
	$Base/Engine3.visible = false
	$CentralExhaust.visible = false
	if level == 1:
		$Base/Engine1.visible = true
	if level == 2:
		$Base/Engine2.visible = true
		$CentralExhaust.visible = true
	if level == 3:
		$Base/Engine3.visible = true
		$CentralExhaust.visible = true

func set_fueltank_level(level):
	fueltank_level = level
	if level == 1:
		$Base/Fueltank1.visible = false
	else:
		$Base/Fueltank1.visible = true

func set_oxygentank_level(level):
	oxygen_tank_level = level

func _on_ShipDamageArea_body_entered(body):
	if body.is_in_group("Bird"):
		body.instakill()
		deal_damage(15)


func _on_ShipDamageArea_area_entered(area):
	if area.is_in_group("Poison"):
		area.instakill()
		deal_damage(20)
	elif area.is_in_group("Oxygen"):
		if add_oxygen():
			area.instakill()
