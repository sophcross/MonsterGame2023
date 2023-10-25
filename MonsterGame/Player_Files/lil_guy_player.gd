extends CharacterBody2D

class_name Player

@export var speed: float = 150.0
@export var jump_velocity: float = -200.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animation_locked: bool = false
var direction: Vector2 = Vector2.ZERO
var was_in_air: bool = false

var on_ladder = false

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		was_in_air = true
	if was_in_air == true:
		land()
		was_in_air = false

	if Input.is_action_just_pressed("jump") and is_on_floor(): 
		jump()
	
	direction = Input.get_vector("left", "right", "up", "down")

	if direction:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	update_animation()
	update_facing_direction()
	
func update_animation():
	if not animation_locked:
		if not is_on_floor():
			animated_sprite.play(("Jump_Start_Loop"))
		else:
			if direction.x != 0:
				animated_sprite.play("Walking")
			else:
				animated_sprite.play("Idle")
		
func update_facing_direction():
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
		
func jump():
	velocity.y = jump_velocity
	animated_sprite.play("Jump_Start")
	animation_locked = true

func _on_animated_sprite_2d_animation_finished():
	if(animated_sprite.animation == "Fall"):
		animation_locked = false
	elif(animated_sprite.animation == "Jump_Start"):
		animation_locked = false

func land():
	animated_sprite.play("Fall")
	animation_locked = true

func should_climb_ladder() -> bool:
	if on_ladder and (Input.is_action_pressed("Up") or Input.is_action_pressed("Down")):
		return true
	else:
		return false

func _on_ladder_checker_body_entered(body):
	on_ladder = true


func _on_ladder_checker_body_exited(body):
	on_ladder = false
