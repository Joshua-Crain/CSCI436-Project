extends Node2D

@onready var sheep_info: Panel = $"Creature Buttons/Sheep/SheepInfo"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sheep_info.visible = false # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Menu button navigations
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


func _on_sheep_pressed() -> void:
	sheep_info.visible = true # Replace with function body.


func _on_sheep_button_quit_pressed() -> void:
	sheep_info.visible = false # Replace with function body.
