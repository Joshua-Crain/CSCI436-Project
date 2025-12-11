extends Node2D

# social
@onready var sheep_info: Panel = $"Creature Buttons/Sheep/SheepInfo"
@onready var sheep_level_label: Label = $"Creature Buttons/Sheep/SheepInfo/sheepLevelLabel"

# productivity
@onready var goblin_info: Panel = $"Creature Buttons/Goblin/GoblinInfo"
@onready var goblin_level_label: Label = $"Creature Buttons/Goblin/GoblinInfo/goblinLevelLabel"

# wellness
@onready var hydra_info: Panel = $"Creature Buttons/Hydra/HydraInfo"
@onready var hydra_level_label: Label = $"Creature Buttons/Hydra/HydraInfo/hydraLevelLabel"

# fun
@onready var sline_info: Panel = $"Creature Buttons/Slime/SlineInfo"
@onready var slime_level_label: Label = $"Creature Buttons/Slime/SlineInfo/slimeLevelLabel"


func _update_sheep_xp_display() -> void:
	var current_socialXP = GlobalData.socialXp
	
	sheep_level_label.text = "XP: " + str(current_socialXP)
	
func _update_goblin_xp_display() -> void:
	var current_productivityXP = GlobalData.productivityXP
	
	goblin_level_label.text = "XP: " + str(current_productivityXP)
	
func _update_hydra_xp_display() -> void:
	var current_wellnessXP = GlobalData.wellnessXP
	
	hydra_level_label.text = "XP: " + str(current_wellnessXP)
	
func _update_slime_xp_display() -> void:
	var current_funXP = GlobalData.funXP
	
	slime_level_label.text = "XP: " + str(current_funXP)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sheep_info.visible = false # Replace with function body.
	_update_sheep_xp_display()
	_update_goblin_xp_display()
	_update_hydra_xp_display()
	_update_slime_xp_display()


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
	_update_sheep_xp_display()
	sheep_info.visible = true
func _on_sheep_button_quit_pressed() -> void:
	sheep_info.visible = false # Replace with function body.

func _on_goblin_pressed() -> void:
	_update_goblin_xp_display()
	goblin_info.visible = true
func _on_goblin_button_quit_pressed() -> void:
	goblin_info.visible = false

func _on_hydra_pressed() -> void:
	_update_hydra_xp_display()
	hydra_info.visible = true
func _on_hydra_button_quit_pressed() -> void:
	hydra_info.visible = false

func _on_slime_pressed() -> void:
	_update_slime_xp_display()
	sline_info.visible = true
func _on_slime_button_quit_pressed() -> void:
	sline_info.visible = false
