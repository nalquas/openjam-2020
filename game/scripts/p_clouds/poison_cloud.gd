extends Area2D
export (int) var cld_seed = 0 setget seed_changer

func _on_ready():
	$Sprite.material = $Sprite.material.duplicate()
func seed_changer(inp):
	$Sprite.material.set_shader_param("cldseed",float(inp))
	cld_seed=inp
