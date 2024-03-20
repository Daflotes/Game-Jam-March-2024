class_name OptionsMenu2
extends Control


@onready var button = $MarginContainer/VBoxContainer/Button as Button


func ready():
	button.button_down.connect(on_exit)
	#set_process(false)
	
## doesnt work for whatever reason	
func on_exit() -> void:
	get_tree().quit()
	print ("testttt")

# if you happen to come across this Dakota, how the FKKKKK does the code below work but the code above doesnt.
func _on_button_pressed():
	get_tree().quit()
	print ("testttt")
