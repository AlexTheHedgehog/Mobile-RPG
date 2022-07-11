extends Node

onready var som = $AudioStreamPlayer

func _on_Button_button_up():
	som.play()
	get_tree().change_scene("res://Batalha.tscn")


func _on_Button2_button_up():
	som.play()
	get_tree().quit()

