extends Node3D

@onready var camera3D = get_node("Camera3D")

func _physics_process(delta):
	if Input.is_action_pressed("camera_left"):
		rotation.y -= 2*delta
	if Input.is_action_pressed("camera_right"):
		rotation.y += 2*delta
	if Input.is_action_pressed("camera_up"):
		rotation.x -= 2*delta
	if Input.is_action_pressed("camera_down"):
		rotation.x += 2*delta
	if Input.is_action_just_released("camera_zoom_out"):
		print("oit")
		camera3D.position.z += 200*delta
	if Input.is_action_just_released("camera_zoom_in"):
		camera3D.position.z -= 200*delta
	if Input.is_action_just_pressed("camera_reset"):
		rotation.x = deg_to_rad(-15)
		rotation.y = 0
		camera3D.position.z = 100
