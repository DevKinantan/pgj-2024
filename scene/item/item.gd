class_name Item
extends CharacterBody2D

@onready var sprite := $Sprite2D
var hook_area: Node2D
var sprites = [
	preload("res://asset/sprite/item/wood.png"),
	preload("res://asset/sprite/item/barrel.png"),
	preload("res://asset/sprite/item/chest.png"),
]
var point := 0


func _ready():
	var idx := randi_range(0, len(sprites)-1)
	point = idx + 1
	sprite.texture = sprites[idx]
	velocity = Vector2.LEFT * randi_range(10, 30)


func _physics_process(_delta):
	move_and_slide()
	if hook_area != null:
		global_position = hook_area.global_position


func _on_area_2d_area_entered(area):
	if area is HookArea:
		#if not area.filled:
		velocity = Vector2.ZERO
		hook_area = area
			#hook_area.filled = true
	
	if area.name == "GatheringArea":
		#hook_area.filled = false
		queue_free()
