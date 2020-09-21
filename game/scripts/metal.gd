extends KinematicBody2D

export (PackedScene) var enemy
var following = false
var collected = false
var time_since_collected = 0
var moved = false
export (AudioStream) var metal_audio
export (AudioStream) var metal_collected

func _ready():
	# Spawn birds
	spawn_birds()
func spawn_birds():
	var enemy_count = randi()%3 + 2 # 2-4 birds
	for enemy_nr in range(enemy_count):
		# Instance birds and position them around this metal
		var enemy_instance = enemy.instance()
		enemy_instance.home = self
		enemy_instance.position = position + Vector2(0.0, 300.0).rotated(((2.0*PI)/float(enemy_count))*float(enemy_nr))
		get_parent().add_child(enemy_instance)

func _physics_process(delta):
	if collected:
		move_and_slide(get_tree().get_nodes_in_group("Homebase")[0].position - position)
		time_since_collected += delta
		$Sprite.scale -= Vector2(0.004,0.004)
		if time_since_collected > 3:
			get_tree().get_nodes_in_group("Homebase")[0].metal += 20
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
	moved = true
	following = !following
	get_main().play_audio(metal_audio)

func collected():
	collected = true
