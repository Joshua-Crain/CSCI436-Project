extends Node2D
@onready var textEntry: LineEdit = $LineEdit
@onready var taskList: ItemList = $ItemList
@onready var createButton: Button = $CreateButton
@onready var deleteButton: Button = $DeleteButton

func _ready() -> void:
	deleteButton.disabled = true
	createButton.disabled = true
	readData()

# readData:
# reads task data from file to list in the menu. Assigns color based on task type.
func readData() -> void:
	var taskFile = FileAccess.open("res://data/savedTasks.txt", FileAccess.READ)
	if(taskFile == null): # attempt to open task file
		printerr(FileAccess.get_open_error())

	taskList.clear()
	# Read data
	var buffer
	while(taskFile.get_position() < taskFile.get_length()): # load task names
		buffer = taskFile.get_line()
		if(buffer == "@FILESEPERATOR"): # start of task data sequence
			# get task name
			var task_name = taskFile.get_line()
			
			# skip to "type"
			for i in range(4):
				taskFile.get_line()
				
			# get task type
			var task_type = taskFile.get_line()
			
			# adding the task to list
			var new_index = taskList.add_item(task_name)
			
			# get task color -> look at getTaskColor(String type)
			var type_color = getTaskColor(task_type)
			
			#get color
			taskList.set_item_custom_fg_color(new_index, type_color) 
		
		
	taskFile.close()

# textEntry text edited:
# ensure textEntry has a given task name to unblock saving.
# remove all '@' chars, as they are reserved for the saved tasks file formatting.
func _on_line_edit_text_changed(new_text: String) -> void:
	var caret = textEntry.caret_column # keep old caret position
	var regex = RegEx.new()
	var text
	regex.compile("[^@]*")
	text = regex.search(new_text)
	text = text.get_string()
	textEntry.text = text
	textEntry.caret_column = caret
	text = text.strip_edges()
	if(text.is_empty()):
		createButton.disabled = true
	else:
		createButton.disabled = false


# get_name
# returns string of the entered task name.
func getTaskName() -> String:
	return(textEntry.text.strip_edges())
	
	
# get color using string, switch statement style
func getTaskColor(type: String) -> Color:
	match type:
		"0": # wellness
			return Color.hex(0x0097bfff)
		"1": # fun
			return Color.hex(0x00ba19ff)
		"2": # social
			return Color.hex(0xbcca00ff)
		"3": # productivity
			return Color.hex(0xb400c1ff)
		_:
			return Color.WHITE

func _on_delete_button_pressed() -> void:
	var selected = taskList.get_selected_items()
	if(selected.size() > 0):
		var taskName = taskList.get_item_text(selected[0])
		deleteTask(taskName)

# delete the given task attributes based on the given task name
func deleteTask(task_given: String) -> void:
	var taskFile = FileAccess.open("res://data/savedTasks.txt", FileAccess.READ)
	var tempFile = FileAccess.open("res://data/tasksTemp.txt", FileAccess.WRITE)
	if(taskFile == null): # attempt to open task file
		printerr(FileAccess.get_open_error())
	if(tempFile == null): # attempt to open temp file
		printerr(FileAccess.get_open_error())
	
	# Read data
	var buffer
	
	while(taskFile.get_position() < taskFile.get_length()): # iterate through task data
		buffer = taskFile.get_line()
		if(buffer == "@FILESEPERATOR"): # skip fileseperator
			continue;
		
		if(buffer.strip_edges() == task_given.strip_edges()): # matching task? do not save to temp, skip
			while(buffer != "@FILESEPERATOR" && !buffer.is_empty()):
				buffer = taskFile.get_line()
		else: # save to temp
			tempFile.store_string("@FILESEPERATOR\n")
			while(buffer != "@FILESEPERATOR" && !buffer.is_empty()):
				tempFile.store_string(str(buffer) + '\n')
				buffer = taskFile.get_line()
	
	taskFile.close()
	tempFile.close()
	# delete old task file, assign temp to new task file
	var dir = DirAccess.open("res://data")
	if(dir == null):
		printerr("Error changing directory.")
		return

	if dir.remove("savedTasks.txt") != OK:
		printerr("Error deleting old task data")
	else:
		printerr("Old task data deleted successfully")
		
	dir.rename("tasksTemp.txt", "savedTasks.txt")
	deleteButton.disabled = true
	
	# clear old tasks and repopulate
	taskList.clear()
	readData()

func _on_item_list_item_selected(_index: int) -> void:
	deleteButton.disabled = false
