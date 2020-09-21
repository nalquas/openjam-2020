tool
extends Node2D
export (PackedScene) var metal_scene
export (PackedScene) var oxy_scene
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
			if x!=0 and y!=0:
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
	#print(get_child_count())
	var new_pos = player_chunk()
	if not playerpos == new_pos:
		#print("Update")
		playerpos = new_pos
		for x in range(-1-distance+playerpos.x,2+distance+playerpos.x):
			for y in range(-1-distance+playerpos.y,2+distance+playerpos.y):
				if abs(x-playerpos.x)==distance+1 or abs(y-playerpos.y)==distance+1:
					if chunks.has(x) and chunks[x].has(y):
						# Remove children, if they are children
						if self.is_a_parent_of(chunks[x][y][0]):
							self.remove_child(chunks[x][y][0])
						if self.is_a_parent_of(chunks[x][y][1]):
							self.remove_child(chunks[x][y][1])
				elif x!=0 and y!=0:
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
					elif (chunks[x][y][0] != null) and (not chunks[x][y][0].is_inside_tree()):
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
