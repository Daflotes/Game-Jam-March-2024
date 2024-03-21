extends RigidBody3D

@onready var floor_checker = get_node("FloorChecker")
@onready var axe = get_node("Axe")

var timer = 0
var axe_impulse = Vector3(0,20,0)

func _physics_process(delta):
	linear_velocity.x = 2
	
	if Input.is_action_just_pressed("left_mouse_button") and floor_checker.is_colliding():
		apply_impulse(Vector3(0,800,0))
	
	timer += delta
	if timer > 0.5:
		timer = 0
		swing_axe()

func swing_axe():
	axe.apply_impulse(axe_impulse)
	axe_impulse = axe_impulse*-1
	print(axe_impulse)
