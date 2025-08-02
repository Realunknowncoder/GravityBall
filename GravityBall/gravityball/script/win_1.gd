extends Area2D

@onready var camera_2d: Camera2D = $"../Camera2D"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var door: AudioStreamPlayer = $door
@onready var launch_sequence: AudioStreamPlayer = $launch_sequence
@onready var launch: AudioStreamPlayer = $launch
@onready var player: RigidBody2D = $"../Player"

var go_played = false
var ready_for_takeoff = false

func _on_body_entered(body):
	if body.is_in_group("player") and not go_played:
		player.sleeping = true
		animation_player.play("win")
		door.play()
		camera_2d.make_current()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "win":
		ready_for_takeoff = true
	if anim_name == "go":
		get_tree().change_scene_to_file("res://scenes/start.tscn")


func _on_door_finished():
	launch_sequence.play()


func _on_launch_sequence_finished() -> void:
	if ready_for_takeoff:
		sprite_2d.play("win_animation")
		if sprite_2d.animation_finished and not go_played:
			launch.play()
			animation_player.play("go")
			go_played = true
			

	
