extends RigidBody3D
@onready var thud_audio = get_node("ThudAudio")
@export var blast_radius = 5

func explode():
	pass


func _on_body_entered(body):
	print(linear_velocity.length())
	if linear_velocity.length() > 1:
		thud_audio.volume_db = clampf(linear_velocity.length()*2, 40, 0)
		thud_audio.play()
