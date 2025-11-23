extends Node2D

@onready var DateButton: Button = $DateButton
@onready var WeeklyButton: Button = $WeeklyButton
@onready var NoneButton: Button = $NoneButton
@onready var NextButton: Button = $NextButton
@onready var BackButton: Button = $BackButton
@onready var DateValueLabel: Label = $Label2
@onready var DateSelection: Node2D = $DateSelection
@onready var WeekSelection: Node2D = $WeekSelection
@onready var year: LineEdit = $DateSelection/year
@onready var month: LineEdit = $DateSelection/month
@onready var day: LineEdit = $DateSelection/day

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


func _ready() -> void:
	var time = Time.get_time_dict_from_system()
	var hour = time.hour % 12
	var minute = time.minute
	
	# assign current time to the hours, minutes, and AMPM options upon opening scene
	hours.value = hour
	minutes.value = minute
	if(time.hour > 12):
		AMPM.button_pressed = true
	else:
		AMPM.button_pressed = false
	
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
	else:
		WeeklyButton.disabled = false
		NoneButton.disabled = false
		DateValueLabel.text = ""
		DateSelection.visible = false

func _on_weekly_button_toggled(toggled_on: bool) -> void:
	if(toggled_on == true):
		DateButton.disabled = true
		NoneButton.disabled = true
		DateValueLabel.text = "Select days of week:"
		WeekSelection.visible = true
	else:
		DateButton.disabled = false
		NoneButton.disabled = false
		DateValueLabel.text = ""
		WeekSelection.visible = false

func _on_none_button_toggled(toggled_on: bool) -> void:
	if(toggled_on == true):
		DateButton.disabled = true
		WeeklyButton.disabled = true
		DateValueLabel.text = ""
	else:
		DateButton.disabled = false
		WeeklyButton.disabled = false
		DateValueLabel.text = ""

## functions to ensure only numbers entered in year, month, or day
func _on_year_text_changed(new_text: String) -> void:
	var caret = year.caret_column # keep old caret position
	var text = numberOnly(new_text)
	year.text = text
	year.caret_column = caret

func _on_month_text_changed(new_text: String) -> void:
	var caret = month.caret_column # keep old caret position
	var text = numberOnly(new_text)
	month.text = text
	month.caret_column = caret

func _on_day_text_changed(new_text: String) -> void:
	var caret = day.caret_column # keep old caret position
	var text = numberOnly(new_text)
	day.text = text
	day.caret_column = caret

## Task Type Selection
func _on_wellness_button_toggled(toggled_on: bool) -> void:
	if(toggled_on == true):
		FunButton.disabled = true
		SocialButton.disabled = true
		ProductivityButton.disabled = true
	else:
		FunButton.disabled = false
		SocialButton.disabled = false
		ProductivityButton.disabled = false


func _on_fun_button_toggled(toggled_on: bool) -> void:
	if(toggled_on == true):
		WellnessButton.disabled = true
		SocialButton.disabled = true
		ProductivityButton.disabled = true
	else:
		WellnessButton.disabled = false
		SocialButton.disabled = false
		ProductivityButton.disabled = false

func _on_social_button_toggled(toggled_on: bool) -> void:
	if(toggled_on == true):
		WellnessButton.disabled = true
		FunButton.disabled = true
		ProductivityButton.disabled = true
	else:
		WellnessButton.disabled = false
		FunButton.disabled = false
		ProductivityButton.disabled = false

func _on_productivity_button_toggled(toggled_on: bool) -> void:
	if(toggled_on == true):
		WellnessButton.disabled = true
		FunButton.disabled = true
		SocialButton.disabled = true
	else:
		WellnessButton.disabled = false
		FunButton.disabled = false
		SocialButton.disabled = false

# Clear all fields and go back to task menu
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
