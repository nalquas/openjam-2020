tool 
extends Sprite
export (Vector2) var pos




# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pos.x=pos.x/1.0
	self.material.set_shader_param("Pos",pos)
