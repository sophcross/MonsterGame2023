extends Node2D


func _on_area_2d_area_entered(area):
	print("You Win!")
	get_tree().change_scene_to_file("res://Victory_Screen.tscn")
