extends Node2D

@onready var enemy_spawn_locations := $EnemySpawnLocation
@onready var item_spawn_location := $ItemSpawnLocation

var spawn_locs := []
var enemy_tscn := preload("res://scene/enemy/enemy.tscn")

var item_locs := []
var item_tscn := preload("res://scene/item/item.tscn")


func _ready():
	spawn_locs = enemy_spawn_locations.get_children()
	item_locs = item_spawn_location.get_children()
	spawn_item()


func spawn_enemy():
	var idx = randi_range(0, len(spawn_locs)-1)
	var enemy := enemy_tscn.instantiate()
	enemy.position = spawn_locs[idx].position
	add_child(enemy)


func spawn_item():
	var idx = randi_range(0, len(item_locs)-1)
	var item := item_tscn.instantiate()
	item.position = item_locs[idx].position
	add_child(item)


func _on_timer_timeout():
	spawn_enemy()
	spawn_item()
