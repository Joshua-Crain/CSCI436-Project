extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Menu button navigations
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
