extends Node2D

@onready var DateButton: Button = $DateButton
@onready var WeeklyButton: Button = $WeeklyButton
@onready var NoneButton: Button = $NoneButton
@onready var NextButton: Button = $NextButton
@onready var BackButton: Button = $BackButton
@onready var DateValueLabel: Label = $Label2
@onready var year: LineEdit = $year
@onready var month: LineEdit = $year/month
@onready var day: LineEdit = $year/month/day

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
		year.visible = true
	else:
		WeeklyButton.disabled = false
		NoneButton.disabled = false
		DateValueLabel.text = ""
		year.visible = false

func _on_weekly_button_toggled(toggled_on: bool) -> void:
	if(toggled_on == true):
		DateButton.disabled = true
		NoneButton.disabled = true
		DateValueLabel.text = "Select days of week:"
	else:
		DateButton.disabled = false
		NoneButton.disabled = false
		DateValueLabel.text = ""

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
