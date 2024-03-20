class_name OptionsMenu
extends Control

@onready var exit_button = $MarginContainer/VBoxContainer/Exit_Button as Button

signal exit_options_menu

func ready():
	exit_button.button_down.connect(on_exit_pressed)
	set_process(false)
	
func on_exit_pressed() -> void:
	get_tree().quit()
	print ("testttt")
	exit_options_menu.emit()
	set_process (false)
	print ("test1ttt")

