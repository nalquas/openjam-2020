extends Node

signal menu

func _ready():
	connect("menu", get_parent(), "_on_Game_menu")

func _process(_delta):
	if Input.is_action_just_pressed("menu"):
		$GameMenu.set_visible(!$GameMenu.get_visible())

func _on_GameMenu_menu():
	emit_signal("menu")
	queue_free()
