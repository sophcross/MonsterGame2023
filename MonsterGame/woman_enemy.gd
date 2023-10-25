extends CharacterBody2D


var movespeed = 65

func _ready():
	pass
	
func _process(delta):
	velocity.x = movespeed
	move_and_slide()
	
	if is_on_wall():
		movespeed = -movespeed
		
	if movespeed > 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
