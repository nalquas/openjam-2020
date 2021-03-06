tool
extends ParallaxLayer
export (PackedScene) var chunk_scene

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var playerpos = Vector2(0,0)
var chunks = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(-3,4):
		for y in range(-3,4):
			var chunk = chunk_scene.instance()
			chunk.pos = Vector2(x,y)
			self.add_child(chunk)
			chunk.position=(Vector2(100.0*x,100.0*y))
			if not chunks.has(x):
				chunks[x]={}
			chunks[x][y]=chunk

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var new_pos = player_chunk()
	if not playerpos == new_pos:
		playerpos = new_pos
		for x in range(-3+playerpos.x,4+playerpos.x):
			for y in range(-3+playerpos.y,4+playerpos.y):
				if not chunks.has(x):
					chunks[x]={}
				if not chunks[x].has(y):
					var chunk = chunk_scene.instance()
					chunk.pos = Vector2(x,y)
					self.add_child(chunk)
					chunk.position=(Vector2(100.0*x,100.0*y))
					chunks[x][y]=chunk
			

func playerpos():
	return (get_viewport_rect().size/2 - self.position)

func player_chunk():
	var chunk = playerpos()/self.scale/100
	chunk.x = int(round(chunk.x))
	chunk.y = int(round(chunk.y))
	return chunk
