extends KinematicBody2D

export (PackedScene) var enemy
var following = false
var collected = false
var time_since_collected = 0

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
			queue_free()
	elif following:
			move_and_slide(get_tree().get_nodes_in_group("Player")[0].position - position)

func follow():
	following = !following

func collected():
	collected = true
