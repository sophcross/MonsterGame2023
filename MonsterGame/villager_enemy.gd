extends CharacterBody2D

var target : Node = null  # The player character
var projectile_scene = preload("res://apple_projectile.tscn")

var fire_rate = 2.0  # Adjust the firing rate as needed
var timer = 0

var movespeed = 65

func _process(delta):
	timer += delta
	if timer >= 1.0 / fire_rate:
		shoot_projectile_in_random_direction()
		timer = 0
	
	velocity.x = movespeed
	move_and_slide()
	
	if is_on_wall():
		movespeed = -movespeed
		
	if movespeed > 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
		
func _ready():
	pass  # May not be correct pathing, fix later

func shoot_projectile_in_random_direction():
	pass

func _on_hitbox_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().die()
