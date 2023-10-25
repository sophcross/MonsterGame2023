extends CharacterBody2D

var chase = false
var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player


func _physics_process(delta):
	velocity.y += gravity * delta
	if chase == true:
		get_node("AnimatedSprite2D").play("Chase")
		player = get_node("res://Player_Files/lil_guy_player.gd")
		var direction = Input.get_axis("ui_left", "ui-right")
		if direction:
			velocity.x = direction.x * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)


func _on_player_detection_body_entered(body):
	if body.name == "LilGuy-Player":
		chase = true
		get_node("AnimatedSprite2D").play("Chase")
		


func _on_player_detection_body_exited(body):
		if body.name == "Player":
			chase = false
			get_node("AnimatedSprite2D").play("Idle")
