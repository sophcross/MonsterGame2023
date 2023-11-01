extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func update_animation():
	animated_sprite.play("Idle")

func _on_hitbox_area_entered(area):
	print("Don't get caught!")
	animated_sprite.play("Idle")
