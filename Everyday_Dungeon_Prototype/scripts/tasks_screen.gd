extends Node2D

@onready var add_button: Button = $TaskSystem/TaskMenu/CreateButton
@onready var delete_button: Button = $TaskSystem/TaskMenu/DeleteButton
@onready var line_edit: LineEdit = $TaskSystem/TaskMenu/LineEdit
@onready var item_list: ItemList = $TaskSystem/TaskMenu/ItemList

func _ready() -> void:
	# Start with Add visible and Delete visible
	add_button.visible = true
	delete_button.visible = true
	
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
