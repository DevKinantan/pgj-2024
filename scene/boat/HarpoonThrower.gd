extends Sprite2D

@export var cooldown := 1.0

@onready var projectile_sprite := $Projectile
@onready var timer := $Timer

var projectile_tscn := preload("res://scene/projectile/projectile.tscn")
var projectile_ready := true


func _input(event):
	if event is InputEventMouseMotion:
		var harpoon_angle = global_position.angle_to_point(get_global_mouse_position())
		global_rotation = harpoon_angle
	
	if event.is_action_pressed("Attack") and projectile_ready:
		var projectile = projectile_tscn.instantiate()
		get_parent().add_child(projectile)
		projectile.global_rotation = global_rotation
		projectile.global_position = projectile_sprite.global_position
		projectile.launch()
		projectile_ready = false
		projectile_sprite.visible = false
		timer.start(cooldown)


func _on_timer_timeout():
	projectile_ready = true
	projectile_sprite.visible = true
