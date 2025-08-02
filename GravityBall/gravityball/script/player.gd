extends RigidBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = true
@onready var background: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $Area2D/AudioStreamPlayer
@onready var camera_2d: Camera2D = $"../Camera2D"

var rng = RandomNumberGenerator.new()

func _process(delta):
	if Input.is_action_just_pressed("invert"):
		if direction:
			background.play("invert_gravity")
			gravity_scale = -1 
			
			direction = false
			print(direction)
		else:
			background.play_backwards("invert_gravity")
			gravity_scale = 1
			direction = true
			print(direction)
			

func _on_area_2d_body_entered(body: Node2D):
	if not body.is_in_group("win_station"):
		var my_random_number = rng.randf_range(0.7, 1.3)
		print(my_random_number)
		audio_stream_player.pitch_scale = my_random_number
		audio_stream_player.play()
		
	if body.is_in_group("win_station"):
		camera_2d.enabled = false
