extends CharacterBody3D


const SPEED = 15

const JUMP_VELOCITY = 10

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	#rotate_y(deg_to_rad(SPEED))
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	# Handle jump.
	if Input.is_action_pressed("ui_accept"):# and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# when UP or DOWN arrow pressed
	if direction.z:
		velocity.z = direction.z * SPEED
		# adding pitch motions
		if direction.z > 0 and rotation_degrees.x < 15: 
			rotate_x(deg_to_rad(1))
		elif direction.z < 0 and rotation_degrees.x > -15:
			rotate_x(deg_to_rad(-1))
	
	# when LEFT or RIGHT arrow pressed
	if direction.x:
		velocity.x = direction.x * SPEED
		# adding roll motions
		if direction.x > 0 and rotation_degrees.z > -45: 
			rotate_z(deg_to_rad(-1))
			#rotate_y(deg_to_rad(5))
		elif direction.x < 0 and rotation_degrees.z < 45:
			rotate_z(deg_to_rad(1))
			#rotate_y(deg_to_rad(-5))
	if not direction.z and not direction.x:
		rotate_x(deg_to_rad(-rotation_degrees.x/3))
		rotate_x(deg_to_rad(-rotation_degrees.x/3))
		rotate_x(deg_to_rad(-rotation_degrees.x/3))
		rotate_z(deg_to_rad(-rotation_degrees.z/3))
		rotate_z(deg_to_rad(-rotation_degrees.z/3))
		rotate_z(deg_to_rad(-rotation_degrees.z/3))
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)	

	move_and_slide()
