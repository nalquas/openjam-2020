extends Node

var title = "none"
var loop = false

var fading = false
var fade_countdown_start = 2.5
var fade_countdown = 2.5
var fade_volume_start = 0

func _ready():
	$AudioStreamPlayer.play()

func _process(delta):
	if fading:
		fade_countdown -= delta
		if fade_countdown < 0:
			fading = false
			$AudioStreamPlayer.stop()
			self.queue_free()
		else:
			$AudioStreamPlayer.volume_db = fade_volume_start - ((1.0-(fade_countdown / float(fade_countdown_start))) * abs(-30-fade_volume_start))

func setAudio(audio, volume_db=0):
	$AudioStreamPlayer.stream = audio
	$AudioStreamPlayer.volume_db = volume_db

func despawn(fade=false):
	if fade:
		fading = true
		fade_volume_start = $AudioStreamPlayer.volume_db
	else:
		$AudioStreamPlayer.stop()
		self.queue_free()

func _on_AudioStreamPlayer_finished():
	if loop:
		$AudioStreamPlayer.play()
	else:
		despawn()

