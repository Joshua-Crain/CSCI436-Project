extends Node2D
@onready var textBox: TextEdit = $TextEdit
@onready var taskList: ItemList = $ItemList
@onready var saveButton: Button = $SaveButton
@onready var deleteButton: Button = $DeleteButton
static var taskDir = DirAccess

func _ready() -> void:
	deleteButton.disabled = true
	saveButton.disabled = true
	
	if(taskDir.open("res://data/taskData/") == null): # attempt to open task directorys
		printerr(taskDir.get_open_error())


func _on_item_list_item_selected(index: int) -> void:
	pass # Replace with function body.
