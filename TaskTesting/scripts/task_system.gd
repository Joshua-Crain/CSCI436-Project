extends Node2D

@onready var TaskMenu = $TaskMenu
@onready var taskNameEntry = $TaskMenu/LineEdit
@onready var CreateButton = $TaskMenu/CreateButton
@onready var screen2 = $Screen2
@onready var screen3 = $Screen3
@onready var screen4 = $Screen4
@onready var calendar: Calendar

static var taskData

func _init() -> void:
	pass

func  _ready() -> void:
	TaskMenu.show()
	screen2.hide()
	screen3.hide()
	screen4.hide()

# TaskMenu create button
# transition to next screen
func _on_create_button_pressed() -> void:
	taskData = TaskData.new()
	TaskMenu.hide()
	screen2.show()
	taskData.taskName = TaskMenu.getTaskName()

# Return back to Task Menu from screen2
func _on_cancel_button_pressed() -> void:
	screen2.hide()
	TaskMenu.show()
	taskData = null
	taskNameEntry.text = ""
	CreateButton.disabled = true
