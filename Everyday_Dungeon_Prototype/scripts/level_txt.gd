extends Node

#@onready var name_label = $NameLabel
var type : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	type = get_meta("Type")
	new_name()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#new_name()
	new_name()
	pass
	
func new_name() -> void:
	##name_label.text = 
	#self.text = "craeture"
	if(type == 0):
		##name = "SHEEP"
		self.text = "LEVEL: " + str(get_node("../../CreaturesList/Sheep").level)
	if type == 1:
		##name = "GOBLIN"
		self.text = "LEVEL: " + str(get_node("../../CreaturesList/Goblin").level)
	if type == 2:
		##name = "HYDRA"
		self.text = "LEVEL: " + str(get_node("../../CreaturesList/Hydra").level)
	if type == 3:
		##name = "SLIME"
		self.text = "LEVEL: " + str(get_node("../../CreaturesList/Slime").level)
