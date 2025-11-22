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
	
	
# get color using string, switch statement style
func getTaskColor(type: String) -> Color:
	match type:
		"productivity":
			return Color.RED
		_:
			return Color.YELLOW
	
