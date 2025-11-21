extends Node2D

@onready var add_button: Button = $Panel/VBoxContainer/HBoxContainer/AddButton
@onready var delete_button: Button = $Panel/VBoxContainer/HBoxContainer/DeleteButton
@onready var line_edit: LineEdit = $Panel/VBoxContainer/HBoxContainer/LineEdit
@onready var item_list: ItemList = $Panel/VBoxContainer/ItemList

func _ready() -> void:
	# get existing task data
	
	
	# Start with Add visible and Delete hidden
	add_button.visible = true
	delete_button.visible = false
	
	item_list.connect("item_selected", Callable(self, "_on_item_selected"))


func _on_goals_button_pressed() -> void:
	get_tree().change_scene_to_file("res://goals_screen.tscn")

func _on_tasks_button_pressed() -> void:
	get_tree().change_scene_to_file("res://tasks_screen.tscn")

func _on_home_button_pressed() -> void:
	get_tree().change_scene_to_file("res://home_screen.tscn")

func _on_battle_button_pressed() -> void:
	get_tree().change_scene_to_file("res://battle_screen.tscn")

func _on_creatures_button_pressed() -> void:
	get_tree().change_scene_to_file("res://creatures_screen.tscn")


func _on_add_button_pressed() -> void:
	var text = line_edit.text.strip_edges()
	if text == "":
		return

	# Add new task
	item_list.add_item(text)
	line_edit.clear()


func _on_delete_button_pressed() -> void:
	var selected = item_list.get_selected_items()
	if selected.size() == 0:
		return

	# Remove selected item
	item_list.remove_item(selected[0])

	# Switch buttons
	delete_button.visible = false
	add_button.visible = true


func _on_item_selected(_index: int) -> void:
	add_button.visible = false
	delete_button.visible = true
	
	
