extends Node3D

func _physics_process(delta):
	if Input.is_action_pressed("camera_left"):
		rotation.y -= 2*delta
	if Input.is_action_pressed("camera_right"):
		rotation.y += 2*delta
	if Input.is_action_pressed("camera_up"):
		rotation.x -= 2*delta
	if Input.is_action_pressed("camera_down"):
		rotation.x += 2*delta
	if Input.is_action_just_pressed("camera_reset"):
		rotation.x = deg_to_rad(-15)
		rotation.y = 0
