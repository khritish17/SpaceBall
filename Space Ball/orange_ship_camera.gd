extends Camera3D

var target_node : NodePath = NodePath("..")
var offset = Vector3.ZERO
var space_ship
var ball

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	space_ship = get_node(target_node)
	# calculating the offset
	var spaceship_position = space_ship.global_position
	var camera_position = global_position
	offset = camera_position - spaceship_position
	
	ball = get_parent().get_parent().find_child("ball")
	print(ball.name)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# get the rotation of space_ship
	var ship_position = space_ship.global_transform.origin
	var desired_position = ship_position  + space_ship.global_transform.basis.x * offset.x + space_ship.global_transform.basis.y * offset.y + space_ship.global_transform.basis.z * offset.z
	var smooth_position = lerp(global_transform.origin, desired_position, 0.1)
	global_transform.origin = smooth_position
	
	var ball_position = ball.global_transform.origin
	#look_at(ship_position)
	look_at(ball_position)
	#print(rotations)
