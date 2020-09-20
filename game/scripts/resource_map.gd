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
	for x in range(-2,3):
		for y in range(-2,3):
			var met = metal_scene.instance()
			var oxy = oxy_scene.instance()
			oxy.position=(Vector2(10000.0*(x+randf()),10000.0*(y+randf())))
			met.position=(Vector2(10000.0*(x+randf()),10000.0*(y+randf())))
			self.add_child(oxy)
			self.add_child(met)
			if not chunks.has(x):
				chunks[x]={}

			chunks[x][y]=[met,oxy]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	print(get_child_count())
	var new_pos = player_chunk()
	if not playerpos == new_pos:
		print("Update")
		playerpos = new_pos
		for x in range(-3+playerpos.x,4+playerpos.x):
			for y in range(-3+playerpos.y,4+playerpos.y):
				if abs(x-playerpos.x)==3 or abs(y-playerpos.y)==3:
					if chunks.has(x) and chunks[x].has(y):
						self.remove_child(chunks[x][y][0])
						self.remove_child(chunks[x][y][1])

				else:
					if not chunks.has(x):
						chunks[x]={}
					if not chunks[x].has(y):
						var met = metal_scene.instance()
						var oxy = oxy_scene.instance()
						oxy.position=(Vector2(10000.0*(x+randf()),10000.0*(y+randf())))
						met.position=(Vector2(10000.0*(x+randf()),10000.0*(y+randf())))
						self.add_child(oxy)
						self.add_child(met)
						chunks[x][y]=[met,oxy]
					elif not chunks[x][y][0].is_inside_tree():
						self.add_child(chunks[x][y][0])
						self.add_child(chunks[x][y][1])
func playerpos():
	var players = get_tree().get_nodes_in_group("Player")
	var player_position = Vector2(0,0)
	if (not players == null) and (players.size() > 0):
		player_position = players[0].global_position
	return player_position

func player_chunk():
	var chunk = playerpos()/10000.0
	chunk.x = int(round(chunk.x))
	chunk.y = int(round(chunk.y))
	return chunk
