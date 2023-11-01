extends Node2D

var direction
var speed = 200.0
var lifetime = 2.0
var hit = false
var damage = 1

func _ready():
	await get_tree().create_timer(lifetime).timeout
	die()
	
func die():
	hit = true
	speed = 0
	


func _on_area_2d_area_entered(area):
	if area.get_parent() is CharacterBody2D && !hit:
		area.get_parent().take_damage(1)
		die()
