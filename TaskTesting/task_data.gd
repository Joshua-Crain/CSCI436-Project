extends RefCounted
class_name TaskData

# task attributes
var taskName = null
var taskDateType = null
var taskDateValue = null
var taskTime = null
var taskRecur = null
var taskType = null
var taskReason = null
var taskGain = null
var taskNote = null

func _init(name, dateType, dateValue, time, recur, type, reason, gain, note) -> void:
	taskName = name
	taskDateType = dateType
	taskDateValue = dateValue
	taskTime = time
	taskRecur = recur
	taskType = type
	taskReason = reason
	taskGain = gain
	taskNote = note
