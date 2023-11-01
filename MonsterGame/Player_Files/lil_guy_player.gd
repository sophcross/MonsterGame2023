extends CharacterBody2D

class_name Player

@export var attacking = false

@export var double_jump_velocity : float = -200.0

@export var speed: float = 150.0
@export var jump_velocity: float = -200.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animation_locked: bool = false
var direction: Vector2 = Vector2.ZERO
var was_in_air: bool = false

var has_double_jumped : bool = false

var health = 3

func _ready():
	GameManager.player = self

func process_(delta):
	if Input.is_action_just_pressed("attack"):
		attack()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		was_in_air = true
	else:
		has_double_jumped = false
		
	if was_in_air == true:
		land()
		was_in_air = false

	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jump()
		elif not has_double_jumped:
			velocity.y = double_jump_velocity
			has_double_jumped = true
	
	direction = Input.get_vector("left", "right", "up", "down")

	if direction:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	update_animation()
	update_facing_direction()
	if position.y >= 700:
		die()
	
func update_animation():
	if !attacking:
		if not animation_locked:
			if not is_on_floor():
				animated_sprite.play(("Jump_Loop"))
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
	animated_sprite.play("Jump")
	animation_locked = true

func _on_animated_sprite_2d_animation_finished():
	if(animated_sprite.animation == "Fall"):
		animation_locked = false
	elif(animated_sprite.animation == "Jump_Start"):
		animation_locked = false

func land():
	animated_sprite.play("Fall")
	animation_locked = true


func take_damage(damage):
	health -= damage
	if health <= 0:
		die()
		
func die():
	GameManager.respawn_player()
	#$".".position.x = 0
	#$".".position.y = -15

func attack():
	var overlapping_objects = $Attack_Area.get_overlapping_areas()
	
	for area in overlapping_objects:
		var parent = area.get_parent()
		print(parent.name)
	
	attacking = true
	animated_sprite.play("Spit")

	
