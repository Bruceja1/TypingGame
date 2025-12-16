# Typing on screen, copying the text above.

# TODO: 
# punctuation
# wpm score
# input custom text
# GUI

extends Node

@onready var text = $Text.text

var typed_event : InputEventKey
var typed_char : String

var current_text_index : int = -1
var current_text_char : String

var game_complete : bool = false

func _ready() -> void:
	$Label.text = ""
	$Shadow.text = text
	find_next_text_char()

func _input(event):
	# Releasing a key also counts as an event, 
	# checking only for event.pressed prevents double inputs.
	# https://docs.godotengine.org/en/4.4/tutorials/inputs/input_examples.html#events-versus-polling
	if event is InputEventKey and event.pressed and not game_complete:
		typed_event = event
		typed_char = convert_typed_event_to_string(typed_event)
		if typed_char == current_text_char:
			$Label.text += typed_char
			find_next_text_char()
		
func find_next_text_char():
	current_text_index += 1
	if current_text_index == len(text):
		print("GAME COMPLETE")
		game_complete = true
		return
		 
	current_text_char = text[current_text_index]
	return 

func convert_typed_event_to_string(event: InputEventKey) -> String:
	var char : String = event.as_text_key_label().to_lower()
	match char:
		"space":
			char = " "
	return char
	
