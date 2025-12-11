extends Node

##var file = FileAccess.open("user://savedCreatures.dat", FileAccess.WRITE_READ)
var c_name: String = "Creature"
var level : int = 0
var xp : int = 0
var type: int = 0
## 0 = sheep
## 1 = goblin
## 2 = hydra
## 3 = slime
## this should be changed to a custom variable type in future


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	type = get_meta("Type")
	#type = 15
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


## exports the relevant data for a character to file in binary
func export_to_bin(file: FileAccess) -> void:
	## storing the type as an integer
	file.store_32(type) 
	## storing the creature's name's length
	file.store_32(c_name.length())
	## storing the creature's name
	file.store_string(c_name)
	## storing the creature's level
	file.store_32(level)
	## storing the creature's current XP
	file.store_32(xp)
	
func import_from_bin(file: FileAccess) -> void:
		## MUST be collected in the same order they were saved
		## collect type as int
		type = file.get_32()
		## collecting the length of the name, then setting the name as a string
		name = "";
		var name_length := file.get_32()
		for i in name_length:
			c_name += char(file.get_8())
		## collecting the level
		level = file.get_32()
		## collecting cur xp
		xp = file.get_32()
		
	
	
	
