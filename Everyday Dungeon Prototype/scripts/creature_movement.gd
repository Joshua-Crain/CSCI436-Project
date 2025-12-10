extends Node
#385-1020 (Y LIMITS)
#134-590 (X LIMITS)
#@onready var self: $self
@onready var x_min: int = 134
@onready var x_max: int = 590
@onready var y_min: int = 385
@onready var y_max: int = 1020
@onready var target: Vector2 = Vector2(self.position)
@onready var walking: bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if walking:
		self.position = self.position.move_toward(target, 2)
		#print(self.position)
		if self.position == target:
			walking = false
			wait(randf_range(1,10))
			find_new()
			#walking = true
			
	pass

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	print("done!")
	walking = true
	#find_new()
	#print("finding new!")
	
func find_new() -> void:
		var x: float = randf_range(x_min, x_max)
		var y: float = randf_range(y_min, y_max)
		target = Vector2(x, y)
		print(x)
		print(y)
