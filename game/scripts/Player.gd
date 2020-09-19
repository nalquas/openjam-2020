extends KinematicBody2D

export (PackedScene) var scene_bullet

export (Vector2) var direction = Vector2(0.0, -1.0)
export (float) var max_speed = 256.0
export (float) var acceleration = 21.0
export (float) var brake_factor = 0.98
var speed = Vector2(0.0, 0.0)

var mouse_input_disabled = true
var mouse_vector = direction

func _input(event):
	# Mouse input events
	if event is InputEventMouseMotion or event is InputEventMouseButton:
		mouse_input_disabled = false
		
		# TODO Fix mouse vector when camera is scaled
		#if event is InputEventMouseButton:
			#print("event.position: " + String(event.position))
			#print("get_viewport_rect().size: " + String(get_viewport_rect().size))
			#print("get_canvas_transform().origin: " + String(get_canvas_transform().origin))
			#print("global_position: " + String(global_position))
			#print("get_canvas_transform().origin + global_position: " + String(get_canvas_transform().origin + global_position))
			#print("")
		
		mouse_vector = event.position - (get_canvas_transform().origin + global_position)

func _physics_process(delta):
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
	if Input.is_action_pressed("right"):
		direction = direction.rotated(delta * 4.0)
		mouse_input_disabled = true
	
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
		new_bullet.position = position
		get_parent().add_child(new_bullet)

func set_camera(state):
	$Camera2D.current = state
