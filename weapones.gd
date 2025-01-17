extends Node2D

@export var bullet: PackedScene
@export var shoot_cooldown = 0.5
var last_shot_time = 0

func shoot():
	if Time.get_ticks_msec() - last_shot_time <  shoot_cooldown * 1000: 
		return
	last_shot_time = Time.get_ticks_msec()
	
	if bullet:
		print("Spawning bullet...")
		var bullets = bullet.instantiate()
		bullets.position = $Marker2D.global_position
		bullets.rotation = $Marker2D.global_rotation
		get_tree().current_scene.add_child(bullets)
	
	else:
		print("no bullet scene")
	
