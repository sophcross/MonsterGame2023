extends Node2D

var activated = false

func activate():
	activated = true
	$AnimationPlayer.play("Activated")

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player && !activated:
		activate()
		if activated:
			get_tree().change_scene_to_file("res://BossLevel.tscn")