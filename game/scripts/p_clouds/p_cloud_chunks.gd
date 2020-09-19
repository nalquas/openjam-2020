tool
extends Node2D
export (PackedScene) var cloud

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(3):
		var nc = cloud.instance()
		self.add_child(nc)
		nc.cld_seed=randi()
		nc.position=Vector2(50-randf()*200,50-randf()*200)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
