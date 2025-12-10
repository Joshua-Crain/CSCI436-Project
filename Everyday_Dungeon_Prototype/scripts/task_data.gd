extends RefCounted
class_name TaskData

# task attributes
static var taskName
static var taskDateType
static var taskDateValue
static var taskTime
static var taskRecur
static var taskType
static var taskReason
static var taskGain
static var taskNote

func _init() -> void:
	taskName = null
	taskDateType = null
	taskDateValue = null
	taskTime = null
	taskRecur = null
	taskType = null
	taskReason = null
	taskGain = null
	taskNote = null
