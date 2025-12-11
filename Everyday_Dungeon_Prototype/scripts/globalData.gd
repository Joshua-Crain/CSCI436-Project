extends Node

var wellnessXP : int = 12
var funXP : int = 25
var socialXp: int = 100
var productivityXP: int = 9
var task_reward: int = 4


func add_xp_task_type(task_type: String):
	match task_type:
		"0": # wellness
			wellnessXP += task_reward
			print("Complete wellness task")
		"1": # fun
			funXP += task_reward
			print("Complete fun task")
		"2": # social
			socialXp += task_reward
			print("Complete social task")
		"3": # productivity
			productivityXP += task_reward
			print("Complete productivity task")
		_:
			print("Unknown task")
