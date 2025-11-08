extends Node

var money = 0
var timeline0 = false
var timeline1 = false
var timeline2 = false
var timeline3 = false
var timeline4 = false
#NOTE This class is our game manager and handles the players money and loading scenes
#These functions can be called globally from anywhere

func reset_money():
	money = 0

func add_money(addmoney : int):
	money += addmoney

func load_next_level(next_scene : PackedScene):
	print("load_next_level: ", next_scene)
	get_tree().change_scene_to_packed(next_scene)

func load_same_level():
	get_tree().reload_current_scene()

func hide_lester():
	var root = get_tree().current_scene
	var lester = root.find_child("Lester", true, false) # Search for Lester recursively, not owned by another scene
	if lester:
		lester.visible = false

func show_lester_dead():
	var root = get_tree().current_scene
	var lester = root.find_child("LesterDead", true, false) # Search for Lester recursively, not owned by another scene
	if lester:
		lester.visible = true
