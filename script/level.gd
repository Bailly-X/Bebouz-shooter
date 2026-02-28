extends Node2D

@export var zombie_scene: PackedScene
@export var dasher_scene: PackedScene
@export var ghost_scene: PackedScene
@onready var player = $Player
@export var upgrade_scene: PackedScene
@export var upgrade_multi_scene: PackedScene

var score = 0
@onready var score_label = $UI/ScoreLabel

func _ready():
	randomize()

func _on_spawn_timer_timeout():
	if not player: return
	
	var enemy = null
	var roll = randf()
	
	if roll < 0.2 and dasher_scene:
		enemy = dasher_scene.instantiate()
	elif roll < 0.4 and ghost_scene:
		enemy = ghost_scene.instantiate()
	elif zombie_scene:
		enemy = zombie_scene.instantiate()
		
	if enemy:
		var random_angle = randf() * TAU
		var spawn_pos = player.global_position + Vector2(cos(random_angle), sin(random_angle)) * 600.0
		enemy.global_position = spawn_pos
		add_child(enemy)

func add_score(points):
	score += points
	score_label.text = "Score: " + str(score)

func _on_upgrade_timeout() -> void:
	if not player: return
	
	var upg = null
	var roll = randf()
	if roll < 0.5 and upgrade_scene:
		upg = upgrade_scene.instantiate()
	elif upgrade_multi_scene:
		upg = upgrade_multi_scene.instantiate()
		
	if upg:
		var random_angle = randf() * TAU
		var spawn_pos = player.global_position + Vector2(cos(random_angle), sin(random_angle)) * 200.0
		upg.global_position = spawn_pos
		add_child(upg)
