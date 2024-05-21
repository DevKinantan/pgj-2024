class_name Projectile
extends CharacterBody2D

@export var speed := 150


func _physics_process(_delta):
	move_and_slide()


func launch():
	var target_position = global_position.direction_to(get_global_mouse_position())
	velocity = target_position * speed


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
