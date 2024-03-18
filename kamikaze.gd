extends RigidBody3D
@onready var explosion_audio = get_node("ExplosionAudio")
@onready var blast_area = get_node("BlastArea")

var max_explosion_impulse = 5
var can_explode = true

func explode():
	explosion_audio.play()
	var bodies_to_blast = blast_area.get_overlapping_bodies()
	for b in bodies_to_blast:
		if b.has_method("apply_impulse"):
			var impulse_direction = (b.position - position).normalized()
			var impulse_power = max_explosion_impulse/(b.position-position).length()
			impulse_power = min(impulse_power, max_explosion_impulse)
			if impulse_direction == Vector3(0,0,0):
				impulse_direction = Vector3(0,1,0)
				impulse_power = max_explosion_impulse
				
			print("dir: " +str(impulse_direction) + " power: " + str(impulse_power))
			var impulse_vector = impulse_direction*impulse_power
			b.apply_impulse(impulse_vector, position)

func _on_body_entered(body):
	if can_explode:
		gravity_scale = 1
		explode()
		can_explode = false
