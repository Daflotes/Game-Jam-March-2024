extends Node3D
@onready var root_scene = get_tree().get_root()
@onready var pivot_point = get_node("PivotPoint")
@onready var shoot_from_point = get_node("PivotPoint/Barrel/ShootFromPoint")
@onready var cannon_angle_adjust_audio = get_node("Audio/CannonAngleAdjustAudio")
@onready var cannon_fire_audio = get_node("Audio/CannonFireAudio")

var unit_scene = preload("res://unit.tscn")
var cannon_angle = 0

@export var angle_change_per_second = 1
@export var cannon_power = 20 #magnitude of unit velocity

func _physics_process(delta):
	
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()
	
	if Input.is_action_pressed("ui_up"):
		pivot_point.rotation.z += angle_change_per_second*delta
		cannon_angle_adjust_audio.play()
	elif Input.is_action_pressed("ui_down"):
		pivot_point.rotation.z -= angle_change_per_second*delta
		cannon_angle_adjust_audio.play()
	else:
		cannon_angle_adjust_audio.stop()
		
	if Input.is_action_just_pressed("ui_accept"):
		var unit_instance = unit_scene.instantiate()
		unit_instance.position = shoot_from_point.global_position
		var shoot_vector = Vector3(1,0,0).rotated(Vector3(0,0,1), pivot_point.rotation.z)
		unit_instance.linear_velocity = shoot_vector*cannon_power
		root_scene.add_child(unit_instance)
		cannon_fire_audio.play()
