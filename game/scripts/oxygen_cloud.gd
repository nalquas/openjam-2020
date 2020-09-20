extends Area2D

export (int) var cld_seed = 0 setget seed_changer

func _on_ready():
	$Sprite.material = $Sprite.material.duplicate()

func seed_changer(inp):
	if inp!=0:
		if get_child_count()==2:
			$Sprite.material = $Sprite.material.duplicate()
			$Sprite.material.set_shader_param("cldseed",float(inp))
			cld_seed=inp

func _on_OxygenCloud_body_entered(body):
	if body.is_in_group("Player"):
		body.add_oxygen()
		queue_free()