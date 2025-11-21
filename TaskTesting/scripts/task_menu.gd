extends Node2D
@onready var textEntry: LineEdit = $LineEdit
@onready var taskList: ItemList = $ItemList
@onready var createButton: Button = $CreateButton
@onready var deleteButton: Button = $DeleteButton

func _ready() -> void:
	deleteButton.disabled = true
	createButton.disabled = true
	
	var taskFile = FileAccess.open("res://data/savedTasks.txt", FileAccess.READ)
	if(taskFile == null): # attempt to open task file
		printerr(FileAccess.get_open_error())

	# Read data
	var buffer
	while(taskFile.get_position() < taskFile.get_length()): # load task names
		buffer = taskFile.get_line()
		if(buffer == "FILESEPERATOR"): # start of task data sequence
			buffer = taskFile.get_line()
			taskList.add_item(buffer)
		
	taskFile.close()


func _on_item_list_item_selected(index: int) -> void:
	pass # Replace with function body.

# textEntry text edited:
# ensure textEntry has a given task name to unblock saving.
func _on_line_edit_text_changed(new_text: String) -> void:
	new_text = new_text.strip_edges()
	if(new_text.is_empty()):
		createButton.disabled = true
	else:
		createButton.disabled = false


# get_name
# returns string of the entered task name.
func getTaskName() -> String:
	return(textEntry.text.strip_edges())
