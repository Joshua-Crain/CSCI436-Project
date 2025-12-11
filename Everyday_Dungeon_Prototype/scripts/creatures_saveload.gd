extends Node
const SAVE_BINARY := "user://savedCreatures.dat"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var err = load_binary()
	if(err == 0):
		save_binary()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	##save_binary()
	pass

func save_binary() -> void:
	##var file := FileAccess.new()
	var file = FileAccess.open(SAVE_BINARY, FileAccess.WRITE)
	
	## for each child, have it write its data
	var children = get_children()
	for child in children:
		print(child.name)
		child.export_to_bin(file)
	file.close()

func load_binary() -> int:
	var file = FileAccess.open(SAVE_BINARY, FileAccess.READ)
	## var error = FileAccess.open(SAVE_BINARY, FileAccess.READ)
	if(file == null):
		return 1
	
	var children = get_children()
	for child in children:
		print(child.name)
		child.import_from_bin(file)
	file.close()
	return 0
