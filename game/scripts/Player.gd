extends KinematicBody2D

export (PackedScene) var scene_bullet

export (Vector2) var direction = Vector2(0.0, -1.0)
export (float) var max_speed = 512.0
export (float) var acceleration = 21.0
export (float) var brake_factor = 0.98
export (int) var hp = 100
export (float) var fuel = 100.0
export (int) var oxygen = 100.0
export (int) var ammo = 100
var speed = Vector2(0.0, 0.0)

var mouse_input_disabled = true
var mouse_vector = direction
var joy_input_disabled = true
var joy_vector = direction

var use_left_barrel = true

var tracked_metal

func _input(event):
	# Mouse input events
	if event is InputEventMouseMotion or event is InputEventMouseButton:
		mouse_input_disabled = false
		joy_input_disabled = true
		mouse_vector = get_global_mouse_position() - position
	elif event is InputEventJoypadMotion:
		mouse_input_disabled = true
		joy_input_disabled = false
	
	#activating tractorbeam
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

func _physics_process(delta):
	print(position)
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
	if thrust > 0:
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
	if Input.is_action_just_pressed("shoot"):
		var new_bullet = scene_bullet.instance()
		new_bullet.direction = direction
		new_bullet.rotation = direction.angle()
		if use_left_barrel:
			new_bullet.position = $LeftBarrel.global_position
		else:
			new_bullet.position = $RightBarrel.global_position
		use_left_barrel = !use_left_barrel
		get_parent().add_child(new_bullet)

func set_camera(state):
	$Camera2D.current = state

func deal_damage(damage):
	self.hp -= damage

func add_oxy():
	pass
