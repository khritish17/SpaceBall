extends CharacterBody3D

var forward_speed = 0
var max_forward_speed = 30
var target_forward_speed = 0


var pitch_input = 0
var pitch_speed = 0.5
var prev_pitch_val = 0

var turn_input = 0
var turn_speed = 0.75
var level_speed = 3.0

var accleration = 9.8

func get_inputs(delta):
	# forward motion
	
	#target_forward_speed = Input.get_action_strength("throtle_up") * max_forward_speed
	#target_reverse_speed = Input.get_action_strength("throtle_down") * max_forward_speed
	target_forward_speed = 0
	target_forward_speed += Input.get_action_strength("throtle_up") * max_forward_speed
	target_forward_speed -= Input.get_action_strength("throtle_down") * max_forward_speed
	
	pitch_input = 0
	pitch_input -= Input.get_action_strength("pitch_up")
	pitch_input += Input.get_action_strength("pitch_down")
	
	turn_input = 0
	turn_input += Input.get_action_strength("roll_left")
	turn_input -= Input.get_action_strength("roll_right")

func _physics_process(delta):
	get_inputs(delta)
	
	# forward and reverse motion
	forward_speed = lerp(int(forward_speed), int(target_forward_speed), 0.2)
	velocity = transform.basis.z * forward_speed
	
	# pitch action (node up or down motion while plane is climbing up or down)
	prev_pitch_val = pitch_input  * delta * pitch_speed
	transform.basis = transform.basis.rotated(transform.basis.x, prev_pitch_val)
	#transform.basis = transform.basis.rotated(transform.basis.x, lerp(rotation.x, prev_pitch_val, level_speed * delta).normalized)
	
	# left and right turn
	transform.basis = transform.basis.rotated(transform.basis.y, turn_input  * delta * turn_speed)
	
	# roll motion  (banking of plane while turning left or right)
	rotation.z = lerp(rotation.z, -turn_input * turn_speed, level_speed * delta)
	
	
	
		
	move_and_slide()
