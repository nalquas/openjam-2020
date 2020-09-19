tool 
extends Sprite
export (Vector2) var pos




# Called when the node enters the scene tree for the first time.
func _ready():
	self.material=self.material.duplicate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.material.set_shader_param("x",float(pos.x))
	self.material.set_shader_param("y",float(pos.y))
