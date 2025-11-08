extends Node2D

#TextBubble
var talking = false
var player_entered = false
@export var speech : Label
@export var line1 = []

@export var show_text_duration : float = 1.0
@export var silence_duration : float = 1.0

#NOTE Displays the text above an NPC and removes it after a slight delay

func _ready():
	#speech.text = ""
	pass

func _input(event: InputEvent) -> void:
	if player_entered and Dialogic.current_timeline == null:
		if not GameManager.timeline0:
			Dialogic.start("res://Dialogs/timeline0.dtl")
			GameManager.timeline0 = true
	
		if Input.is_action_pressed("Enter") or Input.is_action_pressed("ui_accept"):
			if not GameManager.timeline1:
				Dialogic.start("res://Dialogs/timeline1.dtl")
				GameManager.timeline1 = true
			elif not GameManager.timeline2:
				Dialogic.start("res://Dialogs/timeline2.dtl")
				GameManager.timeline2 = true
			elif not GameManager.timeline3:
				Dialogic.start("res://Dialogs/timeline3.dtl")
				GameManager.timeline3 = true
			elif not GameManager.timeline4:
				Dialogic.start("res://Dialogs/timeline4.dtl")
				GameManager.timeline4 = true

#region Signal Entering & Exiting

func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("player_entered = true")
		player_entered = true
		#talk_tween()
		#speech.text = line1[randi() % line1.size()]

func _on_body_exited(body):
	if body.is_in_group("Player"):
		print("player_entered = false")
		player_entered = false
		await get_tree().create_timer(show_text_duration).timeout #Show the text for a short while after the player leaves
		#speech.text = "*murmur*"
		await get_tree().create_timer(silence_duration).timeout #Show "murmur" for a short while before going silent
		#speech.text = ""
		talking = false


#endregion

#Animate the NPC talking with some simple tweening
func talk_tween():
	talking = true
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.2)
	tween.tween_property(self, "scale", Vector2(0.9, 0.9), 0.2)
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.2)
	tween.tween_property(self, "scale", Vector2.ONE, 0.2)
