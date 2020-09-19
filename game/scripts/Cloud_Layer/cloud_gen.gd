tool
extends Node2D
export (PackedScene) var chunk_scene
export (int) var cld_seed
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(-5,6):
		for y in range(-5,6):
			var chunk = chunk_scene.instance()
			chunk.pos = Vector2(x,y)
			self.add_child(chunk)
			chunk.position=(Vector2(100.0*x,100.0*y))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for chunk in self.get_children():
		chunk.cld_seed=self.cld_seed
