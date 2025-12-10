extends Node2D

@onready var reasonEdit: LineEdit = $ReasonEdit
@onready var gainEdit: LineEdit = $GainEdit
@onready var noteEdit: LineEdit = $NoteEdit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# returnReason:
# Returns reason entry as a string.
# If the entry is empty, return an "@" instead to mark it as empty.
func returnReason() -> String:
	var text = reasonEdit.text.strip_edges()
	if(text.length() == 0):
		text = "@"
	return text
	
# returnGain:
# Returns gain entry as a string.
# If the entry is empty, return an "@" instead to mark it as empty.
func returnGain() -> String:
	var text = gainEdit.text.strip_edges()
	if(text.length() == 0):
		text = "@"
	return text
	
# returnNote:
# Returns note entry as a string.
# If the entry is empty, return an "@" instead to mark it as empty.
func returnNote() -> String:
	var text = noteEdit.text.strip_edges()
	if(text.length() == 0):
		text = "@"
	return text

# cancel button from screen2 pressed
func _on_cancel_button_pressed() -> void:
	reasonEdit.text = ""
	gainEdit.text = ""
	noteEdit.text = ""


func _on_reason_edit_changed(new_text: String) -> void:
	var caret = reasonEdit.caret_column # keep old caret position
	var regex = RegEx.new()
	var text
	regex.compile("[^@]*")
	text = regex.search(new_text)
	text = text.get_string()
	reasonEdit.text = text
	reasonEdit.caret_column = caret
	text = text.strip_edges()


func _on_gain_edit_text_changed(new_text: String) -> void:
	var caret = gainEdit.caret_column # keep old caret position
	var regex = RegEx.new()
	var text
	regex.compile("[^@]*")
	text = regex.search(new_text)
	text = text.get_string()
	gainEdit.text = text
	gainEdit.caret_column = caret
	text = text.strip_edges()


func _on_note_edit_text_changed(new_text: String) -> void:
	var caret = noteEdit.caret_column # keep old caret position
	var regex = RegEx.new()
	var text
	regex.compile("[^@]*")
	text = regex.search(new_text)
	text = text.get_string()
	noteEdit.text = text
	noteEdit.caret_column = caret
	text = text.strip_edges()
