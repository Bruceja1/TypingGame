# Typing on screen, copying the text above.

# TODO: 
# wpm score
# input custom text
# GUI

extends Node

@onready var text = $Text.text
@onready var timer = $Timer

var typed_event : InputEventKey
var typed_char : String

var current_text_index : int = -1
var current_text_char : String

var game_complete : bool = false

var words_typed : int = 0
var seconds_passed : int = 0
var wpm: int = 0

func _ready() -> void:
	$Timer.start()
	$Label.text = ""
	$Shadow.text = text
	find_next_text_char()

func _input(event):
	# Releasing a key also counts as an event, 
	# checking only for event.pressed prevents double inputs.
	# https://docs.godotengine.org/en/4.4/tutorials/inputs/input_examples.html#events-versus-polling
	if event is InputEventKey and event.pressed and not game_complete:
		typed_event = event
		# Source: https://www.youtube.com/watch?v=qRPI_c9qI1o
		typed_char = PackedByteArray([typed_event.unicode]).get_string_from_utf8()
		if typed_char == current_text_char:
			$Label.text += typed_char
			if typed_char == " ":
				words_typed += 1
				print(str(words_typed))
			find_next_text_char()
		
func find_next_text_char():
	current_text_index += 1
	if current_text_index == len(text):
		print("GAME COMPLETE")
		game_complete = true
		return
		 
	current_text_char = text[current_text_index]
	return 

func _on_timer_timeout() -> void:
	seconds_passed += 1
	$Seconds.text = str(seconds_passed)	
	
	var minutes_passed : float = seconds_passed / 60.0
	wpm = words_typed / minutes_passed
	$WPM.text = str(wpm)
