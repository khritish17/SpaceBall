extends CharacterBody3D

var forward_speed = 0
var reverse_speed = 0
var max_forward_speed = 10
var target_forward_speed = 0
var target_reverse_speed = 0


var pitch_input = 0
var pitch_speed = 0.5

var turn_input = 0
var turn_speed = 0.75
var level_speed = 3.0

var accleration = 9.8

func get_inputs(delta):
	# forward motion
	
	target_forward_speed = Input.get_action_strength("throtle_up") * max_forward_speed
	target_reverse_speed = Input.get_action_strength("throtle_down") * max_forward_speed
	
	pitch_input = 0
	pitch_input -= Input.get_action_strength("pitch_up")
	pitch_input += Input.get_action_strength("pitch_down")
	
	turn_input = 0
	turn_input += Input.get_action_strength("roll_left")
	turn_input -= Input.get_action_strength("roll_right")
	if Input.get_action_strength("roll_left"):
		print("Roll LEFT")
		print(Input.get_action_strength("roll_left"))
	if Input.get_action_strength("roll_right"):
		print("Roll RIGHT")
		print(Input.get_action_strength("roll_right"))

func _physics_process(delta):
	get_inputs(delta)
	
	# forward and reverse motion
	forward_speed = lerp(int(forward_speed), int(target_forward_speed), accleration*delta)
	reverse_speed = lerp(int(reverse_speed), int(target_reverse_speed), accleration*delta)
	if forward_speed:
		velocity = transform.basis.z * forward_speed
	else:
		velocity.z = lerp(int(velocity.z), 0, accleration*delta)
	if reverse_speed:
		velocity = -transform.basis.z * reverse_speed
	else:
		velocity.z = lerp(int(velocity.z), 0, accleration*delta)
	
	# pitch action
	transform.basis = transform.basis.rotated(transform.basis.x, pitch_input  * delta * pitch_speed)
	# left and right turn
	transform.basis = transform.basis.rotated(transform.basis.y, turn_input  * delta * turn_speed)
	#transform.basis = transform.basis.rotated(transform.basis.z, turn_input  * delta * turn_speed)
	rotation.z = lerp(rotation.z, -turn_input * turn_speed, level_speed * delta)
	#$Mesh/Body.rotation.y = lerp($Mesh/Body.rotation.y, turn_input, level_speed * delta)
	
	
		
	move_and_slide()
