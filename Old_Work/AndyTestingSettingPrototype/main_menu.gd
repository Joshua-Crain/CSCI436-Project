extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_button.visible = true
	options.visible = false

@onready var main_button: VBoxContainer = $MainButton
@onready var options: Panel = $Options


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	print("Pressed")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_settings_pressed() -> void:
	print("hi")
	main_button.visible = false
	options.visible = true


func _on_back_pressed() -> void:
	_ready() # Replace with function body.
