#tool
extends Node2D
export (PackedScene) var chunk_scene
export (Vector2) var player_coord
export (int) var distance = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var playerpos = Vector2(0,0)
var chunks = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(-distance,1+distance):
		for y in range(-distance,1+distance):
			if abs(x)+abs(y)>2:
				var chunk = chunk_scene.instance()
				self.add_child(chunk)
				chunk.position=(Vector2(200.0*x,200.0*y))
				if not chunks.has(x):
					chunks[x]={}
				chunks[x][y]=chunk

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var new_pos = player_chunk()
	if not playerpos == new_pos:
		playerpos = new_pos
		for x in range(-1-distance+playerpos.x,2+distance+playerpos.x):
			for y in range(-1-distance+playerpos.y,2+distance+playerpos.y):
				if abs(x-playerpos.x)==distance+1 or abs(y-playerpos.y)==distance+1:
					if chunks.has(x) and chunks[x].has(y):
						if self.is_a_parent_of(chunks[x][y]):
							self.remove_child(chunks[x][y])
						chunks[x].erase(y)
				elif abs(x)+abs(y)>2:
					if not chunks.has(x):
						chunks[x]={}
					if not chunks[x].has(y) :#and abs(x)+abs(y)>2:
						var chunk = chunk_scene.instance()
						self.add_child(chunk)
						chunk.position=(Vector2(200.0*x,200.0*y))
						chunks[x][y]=chunk
			

func playerpos():
	return player_coord

func player_chunk():
	var chunk = playerpos()/self.scale/200
	chunk.x = int(round(chunk.x))
	chunk.y = int(round(chunk.y))
	return chunk
