extends KinematicBody2D

export (PackedScene) var enemy
var following = false
var collected = false
var time_since_collected = 0

export (AudioStream) var metal_audio
export (AudioStream) var metal_collected

# Called when the node enters the scene tree for the first time.
func _ready():
	var enemys = randi()%3+2
	for enemy_nr in range(enemys):
		var en = enemy.instance()
		en.home=self
		en.position = self.position + Vector2(0,300).rotated(2*PI/enemys*enemy_nr)
		self.get_parent().add_child(en)



func _process(delta):
	if collected:
		move_and_slide(get_tree().get_nodes_in_group("Homebase")[0].position - position)
		time_since_collected += delta
		$Sprite.scale -= Vector2(0.004,0.004)
		if time_since_collected > 3:
			get_tree().get_nodes_in_group("Homebase")[0].metal += 10
			get_main().play_audio(metal_collected)
			queue_free()
	elif following:
			move_and_slide(get_tree().get_nodes_in_group("Player")[0].position - position)

func get_main():
	# Get Main node
	var mains = get_tree().get_nodes_in_group("Main")
	if (not mains == null) and (mains.size() > 0):
		return mains[0]

func follow():
	following = !following
	get_main().play_audio(metal_audio)

func collected():
	collected = true
