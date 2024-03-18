extends RigidBody3D

@onready var floor_checker = get_node("FloorChecker")

func _physics_process(_delta):
	linear_velocity.x = 2
	
	if Input.is_action_just_pressed("left_mouse_button") and floor_checker.is_colliding():
		linear_velocity.y = 8
