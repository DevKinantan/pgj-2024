class_name Boat
extends StaticBody2D

@onready var fishing_line := $FishingLine
@onready var hook := $Hook
@onready var harpoon_thrower := $HarpoonThrower
@onready var heart_sprite := $CanvasLayer/TextureRect

@onready var boat_sprite := $BoatSprite
@onready var hook_sprite := $Hook
@onready var restart_button := $Control/Button

var main := load("res://scene/main.tscn")

var hook_origin_position := Vector2.ZERO
var hook_depth := 0:
	set (value):
		hook_depth = clamp(value, 0, 80)
		hook.global_position.y = hook_origin_position.y + hook_depth
		#hook.global_position.x = hook_origin_position.x - hook_depth/2
		update_fishing_line()

var hp := 5:
	set (value):
		hp = value
		heart_sprite.size.x = 32 * hp
		if hp == 0:
			boat_sprite.visible = false
			hook_sprite.visible = false
			restart_button.visible = true


func _ready():
	hook_origin_position = hook.global_position
	fishing_line.global_position = Vector2.ZERO
	update_fishing_line()


func _input(event):
	if event.is_action_pressed("Reel Down", true):
		hook_depth += 1
	elif event.is_action_pressed("Reel Up", true):
		hook_depth -= 1


func update_fishing_line():
	var boat_join := $BoatSprite/Join
	var hook_join := $Hook/Join

	fishing_line.set_point_position(0, boat_join.global_position)
	fishing_line.set_point_position(1, hook_join.global_position)


func _on_area_2d_area_entered(area):
	if area.get_parent() is Enemy:
		hp -= 1


func _on_gathering_area_area_entered(area):
	if area.get_parent() is Item:
		print("Item gathered")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scene/main.tscn")
