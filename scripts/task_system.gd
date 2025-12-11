extends Node2D

@onready var TaskMenu = $TaskMenu
@onready var taskNameEntry = $TaskMenu/LineEdit
@onready var CreateButton = $TaskMenu/CreateButton
@onready var screen2 = $Screen2
@onready var screen3 = $Screen3
@onready var calendar: Calendar

@onready var hours: SpinBox = $Screen2/TimeSelection/Hours
@onready var minutes: SpinBox = $Screen2/TimeSelection/Minutes
@onready var AMPM: CheckButton = $Screen2/TimeSelection/AMPM

static var taskData

func _init() -> void:
	pass

func  _ready() -> void:
	TaskMenu.show()
	screen2.hide()
	screen3.hide()

# writeTask
# writes task to file with all given attributes in a TaskData object.
func writeTask(task: TaskData) -> void:
	var file = FileAccess.open("res://data/savedTasks.txt", FileAccess.READ_WRITE)
	if(file == null):
		FileAccess.get_open_error()
	
	file.seek_end()
	file.store_string("@FILESEPERATOR\n")
	file.store_string(str(task.taskName) + '\n')
	file.store_string(str(task.taskDateType) + '\n')
	file.store_string(str(task.taskDateValue) + '\n')
	file.store_string(str(task.taskTime) + '\n')
	file.store_string(str(task.taskRecur) + '\n')
	file.store_string(str(task.taskType) + '\n')
	file.store_string(str(task.taskReason) + '\n')
	file.store_string(str(task.taskGain) + '\n')
	file.store_string(str(task.taskNote) + '\n')
	
	file.close()

# TaskMenu create button
# transition to next screen
func _on_create_button_pressed() -> void:
	var time = Time.get_time_dict_from_system()
	var currentHour = time.hour % 12
	var currentMinute = time.minute
	
	# assign current time to the hours, minutes, and AMPM options upon opening scene
	hours.value = currentHour
	minutes.value = currentMinute
	if(time.hour > 12):
		AMPM.button_pressed = true
	else:
		AMPM.button_pressed = false
	
	TaskMenu.hide()
	screen2.show()

# Return back to Task Menu from screen2
func _on_cancel_button_pressed() -> void:
	screen2.hide()
	TaskMenu.show()
	taskData = null
	taskNameEntry.text = ""
	CreateButton.disabled = true

# go from screen2 to screen3
func _on_next_button_pressed() -> void:
	screen2.hide()
	screen3.show()

# go from screen3 to screen2
func _on_back_button_pressed() -> void:
	screen3.hide()
	screen2.show()

# complete task creation signaled from screen3
# a taskData object is created in screen2. Taskname comes from TaskMenu
# task reason, gain, and note comes from screen3.
# Uses taskData object from screen2 as a base to combine to, since it has the most attributes.
# put screen on task menu and hide screen3
func _on_finish_button_pressed() -> void:
	taskData = screen2.returnEntries()
	taskData.taskName = TaskMenu.getTaskName()
	taskData.taskReason = screen3.returnReason()
	taskData.taskGain = screen3.returnGain()
	taskData.taskNote = screen3.returnNote()
	
	writeTask(taskData)
	TaskMenu.readData() # update task list
	taskNameEntry.text = ""
	CreateButton.disabled = true
	screen3.hide()
	TaskMenu.show()
	get_tree().change_scene_to_file("res://Screens/tasks_screen.tscn")
