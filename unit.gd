extends RigidBody3D
@onready var thud_audio = get_node("ThudAudio")
@onready var explosion_audio = get_node("ExplosionAudio")
@onready var blast_area = get_node("BlastArea")

var max_explosion_impulse = 5 
var timer = 0
var explosion_time = 2
var ready_to_explode = true

func _physics_process(delta):
	#explosion on timer
	#timer += delta
	#if timer >= explosion_time and ready_to_explode:
		#explode()
		
	#explosion on input
	if Input.is_action_just_pressed("ui_accept") and ready_to_explode:
		explode()
		
func explode():
	explosion_audio.play()
	var bodies_to_blast = blast_area.get_overlapping_bodies()
	for b in bodies_to_blast:
		if b.has_method("apply_impulse"):
			var impulse_direction = (b.position - position).normalized()
			var impulse_power = max_explosion_impulse/(b.position-position).length()
			if impulse_direction == Vector3(0,0,0):
				impulse_direction = Vector3(0,1,0)
				impulse_power = max_explosion_impulse
				
			print("dir: " +str(impulse_direction) + " power: " + str(impulse_power))
			var impulse_vector = impulse_direction*impulse_power
			b.apply_impulse(impulse_vector, position)
	ready_to_explode = false

func _on_body_entered(_body):
	if linear_velocity.length() > 1:
		thud_audio.volume_db = clampf(linear_velocity.length()*2, 40, 0)
		thud_audio.play()
