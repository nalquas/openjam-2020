extends Area2D
export (int) var cld_seed = 0 setget seed_changer
export (int) var dmg = 20
func _on_ready():
	$Sprite.material = $Sprite.material.duplicate()
func seed_changer(inp):
	if inp!=0:
		if self.get_child_count()==2:
			$Sprite.material = $Sprite.material.duplicate()
			$Sprite.material.set_shader_param("cldseed",float(inp))
			cld_seed=inp
func _physics_process(delta):
	for body in self.get_overlapping_bodies():
		if body.is_in_group("Player"):
			body.add_oxy()
			self.queue_free()
