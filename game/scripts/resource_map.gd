tool
extends Node2D
export (PackedScene) var metal_scene
export (PackedScene) var oxy_scene

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var playerpos = Vector2(0,0)
var chunks = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(-5,6):
		for y in range(-5,6):
			var met = metal_scene.instance()
			var oxy = oxy_scene.instance()
			self.add_child(oxy)
			self.add_child(met)
			print(Vector2(10000.0*(x+randf()),10000.0*(y+randf())))
			oxy.position=(Vector2(10000.0*(x+randf()),10000.0*(y+randf())))
			met.position=(Vector2(10000.0*(x+randf()),10000.0*(y+randf())))
			if not chunks.has(x):
				chunks[x]=[]
			chunks[x].append(y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var new_pos = player_chunk()
	if not playerpos == new_pos:
		playerpos = new_pos
		for x in range(-5+playerpos.x,6+playerpos.x):
			for y in range(-5+playerpos.y,6+playerpos.y):
				if not chunks.has(x):
					chunks[x]=[]
				if not y in chunks[x]:
					var met = metal_scene.instance()
					var oxy = oxy_scene.instance()
					oxy.position=(Vector2(10000.0*(x+randf()),10000.0*(y+randf())))
					met.position=(Vector2(10000.0*(x+randf()),10000.0*(y+randf())))
					self.add_child(oxy)
					self.add_child(met)
					chunks[x].append(y)
			

func playerpos():
	return (get_viewport_rect().size/2 - self.position)

func player_chunk():
	var chunk = playerpos()/self.scale/100
	chunk.x = int(round(chunk.x))
	chunk.y = int(round(chunk.y))
	return chunk
