extends Node3D

var kamikaze_scene = preload("res://Scenes/kamikaze.tscn")
var viking_scene = preload("res://Scenes/viking.tscn")

var pointA
var pointB

func _physics_process(_delta):
	if Input.is_action_just_pressed("left_mouse_button"):
		var viewport := get_viewport()
		var mouse_position := viewport.get_mouse_position()
		var camera := viewport.get_camera_3d()
		
		var origin := camera.project_ray_origin(mouse_position)
		var direction := camera.project_ray_normal(mouse_position)
		
		var ray_length := camera.far
		var end := origin + direction * ray_length
		
		var space_state := get_world_3d().direct_space_state
		var query := PhysicsRayQueryParameters3D.create(origin, end)
		query.collide_with_areas = true
		query.collide_with_bodies = false
		var result := space_state.intersect_ray(query)
		
		var mouse_position_3D := end
		if not result.is_empty():
			mouse_position_3D = result["position"]
		
		pointA = mouse_position_3D
	if Input.is_action_just_released("left_mouse_button"):
		var viewport := get_viewport()
		var mouse_position := viewport.get_mouse_position()
		var camera := viewport.get_camera_3d()
		
		var origin := camera.project_ray_origin(mouse_position)
		var direction := camera.project_ray_normal(mouse_position)
		
		var ray_length := camera.far
		var end := origin + direction * ray_length
		
		var space_state := get_world_3d().direct_space_state
		var query := PhysicsRayQueryParameters3D.create(origin, end)
		query.collide_with_areas = true
		query.collide_with_bodies = false
		var result := space_state.intersect_ray(query)
		
		var mouse_position_3D := end
		if not result.is_empty():
			mouse_position_3D = result["position"]
		
		pointB = mouse_position_3D
		if pointA and pointB:
			if pointA.y >= 5 and (pointA - pointB).length() > 1:
				var kamikaze_instance = kamikaze_scene.instantiate()
				
				kamikaze_instance.linear_velocity = (pointB - pointA).normalized()*20
				#kamikaze_instance.rotation.z = kamikaze_instance.linear_velocity.angle_to(Vector3(1,0,0)) + deg_to_rad(90)
				kamikaze_instance.position = pointA - kamikaze_instance.linear_velocity
				kamikaze_instance.look_at_from_position(pointA, pointB)
				kamikaze_instance.rotation.x += deg_to_rad(90)
				#kamikaze_instance.rotation.y += deg_to_rad(90)
				get_tree().get_root().add_child(kamikaze_instance)
			
			elif pointA.y < 5 and pointA.x < 0:
				var viking_instance = viking_scene.instantiate()
				viking_instance.position = pointA
				get_tree().get_root().add_child(viking_instance)
