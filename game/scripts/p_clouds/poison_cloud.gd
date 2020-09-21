extends Area2D

export (int) var cld_seed = 0 setget seed_changer
export (int) var dmg = 20

export (AudioStream) var explosion_sound

func _on_ready():
	$Sprite.material = $Sprite.material.duplicate()

func seed_changer(inp):
	if inp!=0:
		if get_child_count()==2:
			$Sprite.material = $Sprite.material.duplicate()
			$Sprite.material.set_shader_param("cldseed",float(inp))
			cld_seed=inp

func _on_P_Cloud_body_entered(body):
	if body.is_in_group("Player"):
		get_main().play_audio(explosion_sound)
		body.deal_damage(dmg)
		queue_free()

func get_main():
	# Get Main node
	var mains = get_tree().get_nodes_in_group("Main")
	if (not mains == null) and (mains.size() > 0):
		return mains[0]
