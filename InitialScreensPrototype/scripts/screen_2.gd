extends Node2D

@onready var DateButton: Button = $DateButton
@onready var WeeklyButton: Button = $WeeklyButton
@onready var NoneButton: Button = $NoneButton
@onready var NextButton: Button = $NextButton
@onready var CancelButton: Button = $CancelButton
@onready var DateValueLabel: Label = $Label2
@onready var DateSelection: Node2D = $DateSelection
@onready var WeekSelection: Node2D = $WeekSelection
@onready var TimeSelection: Node2D = $TimeSelection
@onready var TypeSelection: Node2D = $TypeSelection
@onready var year: LineEdit = $DateSelection/year
@onready var month: LineEdit = $DateSelection/month
@onready var day: LineEdit = $DateSelection/day

@onready var recur: CheckBox = $RecurringBox
@onready var recurLabel: Label = $Label3

@onready var Sun: CheckBox = $WeekSelection/CheckBox1
@onready var Mon: CheckBox = $WeekSelection/CheckBox2
@onready var Tues: CheckBox = $WeekSelection/CheckBox3
@onready var Wed: CheckBox = $WeekSelection/CheckBox4
@onready var Thur: CheckBox = $WeekSelection/CheckBox5
@onready var Fri: CheckBox = $WeekSelection/CheckBox6
@onready var Sat: CheckBox = $WeekSelection/CheckBox7

@onready var hours: SpinBox = $TimeSelection/Hours
@onready var minutes: SpinBox = $TimeSelection/Minutes
@onready var AMPM: CheckButton = $TimeSelection/AMPM

@onready var WellnessButton: Button = $TypeSelection/WellnessButton
@onready var FunButton: Button = $TypeSelection/FunButton
@onready var SocialButton: Button = $TypeSelection/SocialButton
@onready var ProductivityButton: Button = $TypeSelection/ProductivityButton

@onready var timeLabel: Label = $TimeSelection/Label
@onready var dayLabel: Label = $TimeSelection/Label2

@onready var dateFlag = false
@onready var dateYearFlag = false
@onready var dateMonthFlag = false
@onready var dateDayFlag = false
@onready var weekFlag = false
@onready var noneFlag = false
@onready var taskTypeFlag = false

func _ready() -> void:
	DateSelection.hide()
	WeekSelection.hide()
	TimeSelection.show()
	TypeSelection.show()

# returnEntries:
# Returns a taskData object that contains the task data from screen2.
func returnEntries() -> TaskData:
	var taskData = TaskData.new()
	
	if(dateFlag): # DATE --------------------------
		taskData.taskDateType = 0
		taskData.taskDateValue = year.text + "-" + month.text + "-" + day.text
		
		if(AMPM.button_pressed):
			taskData.taskTime = str(int(hours.value) + 12) + ':' + str(int(minutes.value))
		else:
			taskData.taskTime = str(int(hours.value)) + ':' + str(int(minutes.value))
			
		if(recur.button_pressed):
			taskData.taskRecur = 1
		else:
			taskData.taskRecur = 0
		
	elif(weekFlag): # WEEK --------------------------
		var weekVal: Array = [0, 0, 0, 0, 0, 0, 0]
		var weekValString: String = ""
		taskData.taskDateType = 1
		if (Sun.button_pressed):
			weekVal[0] = 1
		if (Mon.button_pressed):
			weekVal[1] = 1
		if (Tues.button_pressed):
			weekVal[2] = 1
		if (Wed.button_pressed):
			weekVal[3] = 1
		if (Thur.button_pressed):
			weekVal[4] = 1
		if (Fri.button_pressed):
			weekVal[5] = 1
		if (Sat.button_pressed):
			weekVal[6] = 1
		for i in weekVal:
			weekValString = "".join(weekVal)
			
		taskData.taskDateValue = weekValString
		
		if(AMPM.button_pressed):
			taskData.taskTime = str(hours.value + 12) + ':' + str(minutes.value)
		else:
			taskData.taskTime = str(hours.value) + ':' + str(minutes.value)
		
		if(recur.button_pressed):
			taskData.taskRecur = 1
		else:
			taskData.taskRecur = 0
		
	elif(noneFlag): # NONE --------------------------
		taskData.taskDateType = 2
		taskData.taskDateValue = 0
		taskData.taskTime = 0
		taskData.taskRecur = 0
	else: # error
		printerr("error getting date type")
		return null
	
	# universal attribute
	if(WellnessButton.button_pressed):
		taskData.taskType = 0
	elif(FunButton.button_pressed):
		taskData.taskType = 1
	elif(SocialButton.button_pressed):
		taskData.taskType = 2
	elif(ProductivityButton.button_pressed):
		taskData.taskType = 3
	
	return taskData

# nextCheck:
# Checks that all necessary input fields were completed.
# If true, enable the next button. If false, disable next button and return.
func nextCheck() -> void:
	if(taskTypeFlag == false):
		NextButton.disabled = true
		return

	if(noneFlag == true): # none route
		NextButton.disabled = false
		return
	elif(weekFlag == true): # valid week route
		if(Sun.button_pressed || Mon.button_pressed || Tues.button_pressed ||
		Wed.button_pressed || Thur.button_pressed || Fri.button_pressed ||
		Sat.button_pressed):
			NextButton.disabled = false
			return
	elif(dateFlag == true): # valid date route
		if(dateYearFlag == true && dateMonthFlag == true && dateDayFlag == true):
			NextButton.disabled = false
			return
			
	NextButton.disabled = true

# numberOnly:
# uses RegEx to parse entry for only numbers.
# Returns digits as a string.
func numberOnly(entry: String) -> String:
	var regex = RegEx.new()
	var text
	regex.compile("[0-9]*")
	text = regex.search(entry)
	return text.get_string()

func _on_date_button_toggled(toggled_on: bool) -> void:
	if(toggled_on == true):
		WeeklyButton.disabled = true
		NoneButton.disabled = true
		DateValueLabel.text = "Enter date: yyyy-mm-dd"
		DateSelection.visible = true
		dateFlag = true
	else:
		WeeklyButton.disabled = false
		NoneButton.disabled = false
		DateValueLabel.text = ""
		DateSelection.visible = false
		dateFlag = false
		
	nextCheck()

func _on_weekly_button_toggled(toggled_on: bool) -> void:
	if(toggled_on == true):
		DateButton.disabled = true
		NoneButton.disabled = true
		DateValueLabel.text = "Select days of week:"
		WeekSelection.visible = true
		weekFlag = true
	else:
		DateButton.disabled = false
		NoneButton.disabled = false
		DateValueLabel.text = ""
		WeekSelection.visible = false
		weekFlag = false
		
	nextCheck()

func _on_none_button_toggled(toggled_on: bool) -> void:
	if(toggled_on == true):
		DateButton.disabled = true
		WeeklyButton.disabled = true
		DateValueLabel.text = ""
		timeLabel.hide()
		dayLabel.hide()
		hours.hide()
		minutes.hide()
		AMPM.hide()
		recurLabel.hide()
		recur.hide()
		noneFlag = true
	else:
		DateButton.disabled = false
		WeeklyButton.disabled = false
		DateValueLabel.text = ""
		timeLabel.show()
		dayLabel.show()
		hours.show()
		minutes.show()
		AMPM.show()
		recurLabel.show()
		recur.show()
		noneFlag = false
		
	nextCheck()

## functions to ensure only numbers entered in year, month, or day
func _on_year_text_changed(new_text: String) -> void:
	var caret = year.caret_column # keep old caret position
	var text = numberOnly(new_text)
	year.text = text
	year.caret_column = caret
	if(year.text.length() == 4):
		dateYearFlag = true
	else:
		dateYearFlag = false
		
	nextCheck()

func _on_month_text_changed(new_text: String) -> void:
	var caret = month.caret_column # keep old caret position
	var text = numberOnly(new_text)
	month.text = text
	month.caret_column = caret
	if(month.text.length() == 2):
		dateMonthFlag = true
	else:
		dateMonthFlag = false
		
	nextCheck()

func _on_day_text_changed(new_text: String) -> void:
	var caret = day.caret_column # keep old caret position
	var text = numberOnly(new_text)
	day.text = text
	day.caret_column = caret
	if(day.text.length() == 2):
		dateDayFlag = true
	else:
		dateDayFlag = false
		
	nextCheck()

## Task Type Selection
func _on_wellness_button_toggled(toggled_on: bool) -> void:
	if(toggled_on == true):
		FunButton.disabled = true
		SocialButton.disabled = true
		ProductivityButton.disabled = true
		taskTypeFlag = true
	else:
		FunButton.disabled = false
		SocialButton.disabled = false
		ProductivityButton.disabled = false
		taskTypeFlag = false
		
	nextCheck()

func _on_fun_button_toggled(toggled_on: bool) -> void:
	if(toggled_on == true):
		WellnessButton.disabled = true
		SocialButton.disabled = true
		ProductivityButton.disabled = true
		taskTypeFlag = true
	else:
		WellnessButton.disabled = false
		SocialButton.disabled = false
		ProductivityButton.disabled = false
		taskTypeFlag = false
		
	nextCheck()

func _on_social_button_toggled(toggled_on: bool) -> void:
	if(toggled_on == true):
		WellnessButton.disabled = true
		FunButton.disabled = true
		ProductivityButton.disabled = true
		taskTypeFlag = true
	else:
		WellnessButton.disabled = false
		FunButton.disabled = false
		ProductivityButton.disabled = false
		taskTypeFlag = false
		
	nextCheck()

func _on_productivity_button_toggled(toggled_on: bool) -> void:
	if(toggled_on == true):
		WellnessButton.disabled = true
		FunButton.disabled = true
		SocialButton.disabled = true
		taskTypeFlag = true
	else:
		WellnessButton.disabled = false
		FunButton.disabled = false
		SocialButton.disabled = false
		taskTypeFlag = false

	nextCheck()

# Clear all screen2 fields and go back to task menu
func _on_cancel_button_pressed() -> void:
	WellnessButton.button_pressed = false
	FunButton.button_pressed = false
	SocialButton.button_pressed = false
	ProductivityButton.button_pressed = false
	
	WellnessButton.disabled = false
	FunButton.disabled = false
	SocialButton.disabled = false
	ProductivityButton.disabled = false

	year.text = ""
	month.text = ""
	day.text = ""

	recur.button_pressed = false

	Sun.button_pressed = false
	Mon.button_pressed = false
	Tues.button_pressed = false
	Wed.button_pressed = false
	Thur.button_pressed = false
	Fri.button_pressed = false
	Sat.button_pressed = false

	DateButton.button_pressed = false
	WeeklyButton.button_pressed = false
	NoneButton.button_pressed = false

func _on_check_box_toggled(_toggled_on: bool) -> void:	
	nextCheck()

func _on_next_button_pressed() -> void:
	pass # Replace with function body.
