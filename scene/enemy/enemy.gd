class_name Enemy
extends CharacterBody2D

@onready var tint_player := $TintPlayer
@onready var animation_player := $AnimationPlayer
@onready var timer := $Timer

@export var hp := 2:
	set (value):
		hp = value
		if hp <= 0:
			animation_player.stop()
			velocity = Vector2.DOWN * 30
			$SwimSprite.visible = false
			$DashSprite.visible = true
			global_rotation = 0
			timer.start()

var target: Boat
var target_direction: Vector2
var fallback := false
var speed := 10
var max_speed := 50


func _ready():
	target = get_parent().get_node_or_null("Boat")
	if target != null:
		target_direction = global_position.direction_to(target.global_position)
		velocity = target_direction * speed
		
		global_rotation = global_position.angle_to_point(target.global_position)
	

func _physics_process(_delta):
	if hp > 0:
		if not fallback:
			speed = move_toward(speed, max_speed, 5)
			velocity = target_direction * speed

		elif fallback:
			speed = move_toward(speed, 10, 5)
			velocity = target_direction * -speed
			if global_position.distance_to(target.global_position) > 70:
				fallback = false
				speed = 10
	
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body is Projectile and hp > 0:
		body.queue_free()
		hp -= 1
		tint_player.play("Damaged")

	if body is Boat:
		fallback = true
		velocity = velocity * -1


func _on_timer_timeout():
	queue_free()
