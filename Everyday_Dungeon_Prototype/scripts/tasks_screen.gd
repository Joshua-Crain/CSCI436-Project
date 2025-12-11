extends Node2D

@onready var add_button: Button = $TaskSystem/TaskMenu/CreateButton
@onready var delete_button: Button = $TaskSystem/TaskMenu/DeleteButton
@onready var line_edit: LineEdit = $TaskSystem/TaskMenu/LineEdit
@onready var item_list: ItemList = $TaskSystem/TaskMenu/ItemList

func _ready() -> void:
	# get existing task data
	
	
	# Start with Add visible and Delete hidden
	add_button.visible = true
	delete_button.visible = false
	
	item_list.connect("item_selected", Callable(self, "_on_item_selected"))
	

func _on_goals_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Screens/goals_screen.tscn")

func _on_tasks_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Screens/tasks_screen.tscn")

func _on_home_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Screens/home_screen.tscn")

func _on_battle_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Screens/battle_screen.tscn")

func _on_creatures_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Screens/creatures_screen.tscn")


func _on_add_button_pressed() -> void:
	var text = line_edit.text.strip_edges()
	if text == "":
		return

	# Add new task
	item_list.add_item(text)
	line_edit.clear()


func _on_delete_button_pressed() -> void:
	print("Clicked")
	var selected = item_list.get_selected_items()
	if selected.size() == 0:
		return
		
	#read task
	var index = selected[0]
	#get task type
	var task_type: String = item_list.get_item_metadata(index)
	#add reward
	GlobalData.add_xp_task_type(task_type)
	# Remove selected item
	item_list.remove_item(index)

	# Switch buttons
	delete_button.visible = false
	add_button.visible = true


func _on_item_selected(_index: int) -> void:
	add_button.visible = false
	delete_button.visible = true
	
	
