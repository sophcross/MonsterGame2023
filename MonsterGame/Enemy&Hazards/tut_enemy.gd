extends CharacterBody2D

var chase = false
@export var SPEED: float = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		if chase == true:
			get_node("AnimatedSprite2D").play("chase")
			#player = get_node()
			var direction = Input.get_axis("ui_left", "ui_right")
			if direction:
				velocity.x = move_toward(velocity. x, 0,SPEED)


func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true
		get_node("AnimatedSprite2D").play("chase")

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false
		get_node("AnimatedSprite2D").play("idle")
