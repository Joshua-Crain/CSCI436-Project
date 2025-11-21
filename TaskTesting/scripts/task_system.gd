extends Node2D

@onready var TaskMenu = $TaskMenu
@onready var screen2 = $Screen2
@onready var screen3 = $Screen3
@onready var screen4 = $Screen4
@onready var calendar: Calendar

static var taskData = TaskData.new()

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
	TaskMenu.hide()
	screen2.show()
	taskData.taskName = TaskMenu.getTaskName()
